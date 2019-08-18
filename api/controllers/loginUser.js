'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
var tokenUtils = require('../helpers/tokenUtils');
module.exports = {
  loginUser: loginUser
};
function loginUser(req, res) {
  var service = {
    apiName: 'login',
    requestData: req.swagger.params.body.value
  };
  log.debug(service);
  exports._handleLoginUser(service, function(err, data) {
    if (err) {
      return responseUtils.sendResponse(err, res);
    }
    //res.cookie('token', data.token, { maxAge: 86400 });
    responseUtils.sendResponse(responseUtils.getResponse(data, 'LOGIN_SUCCESSFULL', 'User log in successfull'), res);
  });
}
exports._handleLoginUser = async function(service, callback) {
  try {
    const isValidLoginQuery = {
      sql: 'SELECT customerId FROM ' + queryUtils.TABLES.login.name + ' WHERE phoneNumber=? AND pin=?;',
      data: [service.requestData.phoneNumber, service.requestData.pin]
    };
    const isValidLoginQueryResult = await database.executeSelect(isValidLoginQuery);
    if (_.isEmpty(isValidLoginQueryResult[0])) {
      return callback(
        responseUtils.getErrorResponse('USERNAME_OR_PASSWORD_INCORRECT', 'Username or password is incorrect')
      );
    } else {
      log.info('test=' + isValidLoginQueryResult[0][0].customerId);
      let token = await tokenUtils.getToken(isValidLoginQueryResult[0][0].customerId + '');
      log.info('test=' + token);
      return callback(null, { customerId: isValidLoginQueryResult[0][0].customerId, token });
    }
  } catch (e) {
    log.error(e);
    return callback(responseUtils.getErrorResponse(require('util').inspect(e)));
  }
};

/* click on forget password
   send a link to phone.
   insert reset code.
   set up reset password screen */
