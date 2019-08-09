'use strict';
var _ = require('lodash');
var database = require('../helpers/database');
var log = require('../helpers/log');
var queryUtils = require('../helpers/queryUtils');
var responseUtils = require('../helpers/responseUtils');
var tokenUtils = require('../helpers/tokenUtils');
module.exports = {
  enableProfile: enableProfile
};
function enableProfile(req, res) {
  var vendorId = req.swagger.params.vendorId.value;
  var service = {
    api: 'enableProfile',
    requestData: req.swagger.params.body.value
  };
  service.requestData.vendorId = vendorId;
  // Todo Send inviteURl through sms
  exports._handleEnableProfile(service, function(err, data) {
    if (err) {
      return responseUtils.sendResponse(err, res);
    }
    responseUtils.sendResponse(data, res);
    res.json();
  });
}

exports._handleEnableProfile = async function(service, callback) {
  try {
    const profileQueryData = {
      tableName: queryUtils.TABLES.profile.name,
      data: _.pick(service.requestData, queryUtils.TABLES.profile.columns)
    };
    const customerId = await database.insertToTable(profileQueryData);
    log.info(customerId);
    const vendorMappingQueryData = {
      tableName: queryUtils.TABLES.vendorProfileMapping.name,
      data: {
        customerId: customerId,
        vendorCustomerId: service.requestData.vendorCustomerId,
        vendorId: service.requestData.vendorId
      }
    };
    const vendorMappingResult = await database.insertToTable(vendorMappingQueryData);
    log.info(vendorMappingResult);
    const inviteUrl = exports._createInviteUrl(service);
    log.info(inviteUrl);
    const loginQueryData = {
      tableName: queryUtils.TABLES.login.name,
      data: {
        customerId: customerId,
        phoneNumber: service.requestData.phoneNumber,
        inviteUrl: inviteUrl
      }
    };
    const loginQueryResult = await database.insertToTable(loginQueryData);
    log.info(loginQueryResult);
    return callback(
      null,
      responseUtils.getResponse(
        { inviteUrl },
        'ENABLE_PROFILE_SUCCESSFULL',
        'Profile is successfully enabled for the user'
      )
    );
  } catch (e) {
    log.error(e);
    let userError;
    if (e.code === 'ER_DUP_ENTRY') {
      userError = responseUtils.getErrorResponse('ALREADY_ENABLED_PROFILE', 'Profile already enabled for this user');
    } else {
      userError = e;
    }
    return callback(userError);
  }
};

exports._createInviteUrl = function(service) {
  var appUrl = 'https://app.com/register?';
  var data = _.pick(service.requestData, ['vendorId', 'vendorCustomerId', 'phoneNumber', 'homeStoreNumber']);
  appUrl += 'refCode=' + tokenUtils.getToken(data);
  return appUrl;
};
