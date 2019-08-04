'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
module.exports = {
  enable: enable
};
function enable(req, res) {
  var service = {
    apiName: 'enable',
    requestData: {
      deviceId: req.swagger.params.body.value.deviceId,
      referenceNumber: req.swagger.params.body.value.referenceNumber
    }
  };
  log.debug(service);
  async.waterfall([exports._checkReferenceNumber(service), exports._insertRegistration(service)], function(
    errorResponse,
    data
  ) {
    if (errorResponse) {
      res.status(errorResponse.status);
      return res.json(errorResponse.response);
    }
    service.responseData = responseUtils.getResponse(
      data,
      'ENABLEMENT_SUCCESSFUL',
      'Mobile enabled successfully. Please set up a username and password'
    );
    log.debug(JSON.stringify(service));
    res.json(service.responseData);
  });
}

exports._checkReferenceNumber = _.curry(function(service, callback) {
  log.debug('Inside _checkReferenceNumber');
  var query = {
    sql: queryUtils.getCheckUserQuery(),
    data: [service.requestData.referenceNumber]
  };
  log.debug(query);
  database.executeSelect(query, function(err, data) {
    if (err) {
      return callback(responseUtils.getDbErrorResponse(err));
    }
    if (_.isEmpty(data)) {
      return callback(responseUtils.getOtherResponse('INVALID_REFERENCE_NUMBER', 'Invalid reference number'));
    }
    callback(null, data);
  });
});

exports._insertRegistration = _.curry(function(service, data, callback) {
  log.debug('Inside _insertRegistration');
  var query = {
    tableName: queryUtils.TABLES.REGISTRATION_TABLE,
    data: service.requestData
  };
  log.debug(query);
  database.insertToTable(query, function(err, data) {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return callback(responseUtils.getOtherResponse('ENABLEMENT_FAILURE', 'User Already Registered'));
      } else {
        return callback(responseUtils.getDbErrorResponse(err));
      }
    }
    callback(null, data);
  });
});
