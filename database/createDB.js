var connection = require('./dbConnection')

connection.query('DROP database if exists trelloDB', function(err, result)  {
    if(err) throw err;
    console.log("database dropped");
})
    connection.query("create database trelloDB", function(err, result) {
        if(err) throw err;
        console.log("database created")
    })
