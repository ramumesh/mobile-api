'use strict';
var _ = require('lodash');
var database = require('../helpers/database');
var log = require('../helpers/log');
var responseUtils = require('../helpers/responseUtils');
module.exports = {
  enableProfile: enableProfile
};
function enableProfile(req, res) {
  var vendorId = req.swagger.params.vendorId.value;
  var service = {
    api: 'enableProfile',
    requestData: req.swagger.params.body.value
  };
  var query = {
    tableName: 'em-profile',
    data: service.requestData
  };
  service.requestData.vendorId = vendorId;
  log.debug(service.requestData);
  // Insert to profile table and get emCustomerId
  // Insert to em_vendor_link table
  // Create invite_url
  // Insert to em_login table
  // Send inviteURl through sms
  res.json(
    responseUtils.getOtherResponse('ENABLE_PROFILE_SUCCESSFULL', 'Profile is successfully enabled for the user')
  );
}
