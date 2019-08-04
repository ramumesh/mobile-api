"use strict";

exports.getDbErrorResponse = function(error) {
  return {
    status: 500,
    response: {
      userMessage: error,
      internalMessage: "DATABASE_ERROR"
    }
  };
};
exports.getResponse = function(data, internalMessage, userMessage) {
  return {
    data: data,
    userMessage: userMessage,
    internalMessage: internalMessage
  };
};

exports.getOtherResponse = function(internalMessage, userMessage) {
  return {
    status: 200,
    response: {
      userMessage: userMessage,
      internalMessage: internalMessage
    }
  };
};
