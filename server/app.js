var http = require('http');
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var app = express();
require('./modules/product/controllers/productController')(app, { express: express, path: path});

app.set('view engine', 'html');
app.set('port', process.env.PORT || 3000);
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

/*
* Create server.
* */
app.listen(app.get('port'), function(){
  console.log('Express server is running... ' + app.get('port'));
});

/*
* Error handler function.
* */
app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

module.exports = app;
