'use strict';
var util = require('util');
module.exports = {
  register: register
};
function register(req, res) {
  var service={
      requestData:{
          deviceId:req.swagger.params.body.value.deviceId,
          phoneNumber:req.swagger.params.body.value.phoneNumber,
          referenceNumber:req.swagger.params.body.value.referenceNumber
      },
      responseData:{
          data:{},
          userMessage:"User register successfully. Please login again",
          internalMessage:"REGISTRATION_SUCCESSFULL"

      }
  }
  res.json(service.responseData);
}
