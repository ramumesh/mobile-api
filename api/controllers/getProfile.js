'use strict';
var async = require('async');
var _ = require('lodash');
var database = require('../helpers/database');
var queryUtils = require('../helpers/queryUtils');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
module.exports = {
  getProfile: getProfile
};
function getProfile(req, res) {
  var service = {
    apiName: 'profile',
    requestData: req.swagger.params.customerId.value
  };
  log.debug(service);
  // Validate the login credentials and get the customerId
  res.json(
    responseUtils.getResponse(
      { customerId: req.swagger.params.customerId.value },
      'USER_PROFILE_DATA',
      'User profile data fetched successfully'
    )
  );
}
