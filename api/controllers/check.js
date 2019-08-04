"use strict";
var _ = require("lodash");
var util = require("util");
var database = require("../helpers/database");
var queryUtils = require("../helpers/queryUtils");
var log = require("../helpers/log");
module.exports = {
  check: check
};
function check(req, res) {
  var service = {
    api: "check",
    requestData: {
      deviceId: req.swagger.params.deviceId.value
    }
  };
  var query = {
    sql: queryUtils.getRegistrationQuery(),
    data: [service.requestData.deviceId]
  };
  database.executeSelect(query, function(err, data) {
    if (err) {
      log.error(err);
    }
    if (_.isEmpty(data)) {
      service.responseData = {
        internalMessage: "NOT_ENABLED",
        userMessage: "The device is not registered with mobile."
      };
    } else {
      service.responseData = {
        internalMessage: "ENABLED",
        userMessage: "The device is registered with mobile."
      };
    }
    log.debug(JSON.stringify(service));
    res.json(service.responseData);
  });
}
