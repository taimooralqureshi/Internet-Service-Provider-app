const mysql = require('mysql');
const connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'isp_db',
	port : '3306'

});

connection.connect(function(err) {
    if (err) throw err;
    console.log("Database Connected!");
  });

module.exports = connection;
