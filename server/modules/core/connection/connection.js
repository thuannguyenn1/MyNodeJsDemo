'use strict';
var globalValues = require('../../../globalDefinition');

/*
* Check connection
* */
sequelize
    .authenticate()
    .then(function(err) {
        console.log('Connection has been established successfully.');
    }, function (err) {
        console.log('Unable to connect to the database:', err);
    });

function connection(){
    if(!(this instanceof connection)) {
        return new connection();
    }

    this.sequelize = require('sequelize')(globalValues.databaseName
                                        , globalValues.userDatabaseLogin
                                        , globalValues.databasepassword, {
        host: globalValues.host,
        port: 3306
        });
}



module.exports = connection;