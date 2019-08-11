'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
var tokenUtils = require('../helpers/tokenUtils');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
module.exports = {
  validateUser: validateUser
};
function validateUser(req, res) {
  var service = {
    apiName: 'validate',
    requestData: req.swagger.params.body.value
  };
  exports._handleValidateUser(service, function(err, data) {
    if (err) {
      return responseUtils.sendResponse(err, res);
    }
    log.debug(data);
    responseUtils.sendResponse(data, res);
  });
}

exports._handleValidateUser = async function(service, callback) {
  try {
    const result = await tokenUtils.decodeToken(service.requestData.referenceToken);
    log.info(result);
    const validateQuery = {
      sql: 'SELECT phoneNumber FROM ' + queryUtils.TABLES.login.name + ' WHERE referenceCode=? AND isFirstTime=?;',
      data: [service.requestData.referenceCode, 1]
    };
    const validateQueryResult = await database.executeSelect(validateQuery);
    if (_.isEmpty(validateQueryResult[0])) {
      return callback(responseUtils.getErrorResponse('INVALID_REFERENCE_CODE', 'Invalid reference code'));
    } else {
      if (validateQueryResult[0][0].phoneNumber + '' === +result.phoneNumber + '') {
        return callback(
          null,
          responseUtils.getSuccessResponse('REFERENCE_CODE_VALIDATED_SUCCESSFULLY', 'Valid reference code')
        );
      } else {
        return callback(responseUtils.getErrorResponse('INVALID_REFERENCE_CODE', 'Invalid reference code'));
      }
    }
  } catch (e) {
    log.error(e);
    return callback(responseUtils.getErrorResponse(e.message, e));
  }
};
