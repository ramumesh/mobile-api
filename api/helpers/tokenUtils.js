'use strict';
var jwt = require('jsonwebtoken');
exports.getToken = function(data) {
  return jwt.sign(
    {
      data: data
    },
    'secret',
    { expiresIn: 3 }
  );
};

exports.decodeToken = function(token) {
  jwt.verify(token, 'secret', function(err, decoded) {
    if (err) {
      console.log(err);
    }
    console.log(decoded);
  });
};
