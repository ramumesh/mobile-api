'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
module.exports = {
  registerUser: registerUser
};
function registerUser(req, res) {
  var service = {
    apiName: 'register',
    requestData: req.swagger.params.body.value
  };
  log.debug(service);
  exports._handleRegisterUser(service, function(err, data) {
    if (err) {
      return responseUtils.sendResponse(err, res);
    }
    responseUtils.sendResponse(data, res);
  });
}
exports._handleRegisterUser = async function(service, callback) {
  try {
    const isFirstTimeQuery = {
      sql: 'SELECT isFirstTime FROM ' + queryUtils.TABLES.login.name + ' WHERE phoneNumber=?;',
      data: [service.requestData.phoneNumber]
    };
    const isFirstTimeQueryResult = await database.executeSelect(isFirstTimeQuery);
    if (_.isEmpty(isFirstTimeQueryResult[0])) {
      return callback(
        responseUtils.getErrorResponse(
          'USER_PROFILE_NOT_ENABLED',
          'User profile has not been enabled. Please check with the store.'
        )
      );
    } else if (isFirstTimeQueryResult[0][0].isFirstTime === 0) {
      return callback(
        responseUtils.getErrorResponse(
          'USER_ALREADY_REGISTERED',
          'User can be registerd only once. Please check with the store.'
        )
      );
    } else {
      const updateLoginQuery = {
        tableName: queryUtils.TABLES.login.name,
        condition: {
          phoneNumber: service.requestData.phoneNumber
        },
        data: {
          pin: service.requestData.pin,
          isFirstTime: 0,
          isActive: 1
        }
      };
      const updateLoginResult = await database.updateTable(updateLoginQuery);
      log.info(updateLoginResult);
      return callback(
        null,
        responseUtils.getSuccessResponse('USER_REGISTRATION_SUCCESSFUL', 'User registered successfully.')
      );
    }
  } catch (e) {
    log.error(e);
    return callback(e);
  }
};
