'use strict';
exports.TABLES = {
  REGISTRATION_TABLE: 'registration',
  USER_DETAILS: 'user_details'
};
exports.getRegistrationQuery = function() {
  return 'SELECT * FROM ' + exports.TABLES.REGISTRATION_TABLE + ' WHERE deviceId=?';
};

exports.getCheckUserQuery = function() {
  return 'SELECT * FROM ' + exports.TABLES.USER_DETAILS + ' WHERE referenceNumber=?';
};
