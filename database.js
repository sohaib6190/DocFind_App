var mysql = require('mysql');

var connection = mysql.createConnection({

host:'localhost',
database:'DocFindApp',
user:'root',
password:'shifaFaisal@123'

});


module.exports = connection;