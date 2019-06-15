const mysql = require('mysql')

var connection = mysql.createConnection({
    host: 'localhost', 
    user: 'root', 
    password: '1234'
})

connection.connect((err) => {
    if(err)
    throw err;
    console.log("connected to mysql")
})

module.exports = connection