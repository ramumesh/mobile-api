'use strict';
'use strict';
var SwaggerExpress = require('swagger-express-mw');
var app = require('express')();
var cors = require('cors');
var database = require('./api/helpers/database');
var log = require('./api/helpers/log');
module.exports = app; // for testing
app.use(cors());
var config = {
  appRoot: __dirname // required config
};

SwaggerExpress.create(config, async function(err, swaggerExpress) {
  if (err) {
    throw err;
  }
  try {
    swaggerExpress.register(app);
    await database.initialize();
    var port = process.env.PORT || 8080;
    await app.listen(port);
    log.info('Server started successfully ast port ' + port);
  } catch (e) {
    log.error(e);
    process.exit(1);
  }
});
