/**
 * definition of global values for project.
 */
'use strict';
var eCargoGlobalValue = {
    maximumSelectItems: 10,
    host: 'localhost',
    userDatabaseLogin:'root',
    databasepassword: 'abc@123',
    databaseName: 'ecargo_database',
    allowCros: function (res) {
        res.setHeader('Access-Control-Allow-Origin', '*');

        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

        res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

        res.setHeader('Access-Control-Allow-Credentials', true);
    }
};

module.exports = eCargoGlobalValue;