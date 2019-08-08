'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
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
  log.debug(service);
  // Validate the login credentials and get the customerId
  res.json(responseUtils.getResponse({ customerId: '12345' }));
}
