const mysql = require('mysql')

// var connection = mysql.createConnection({
//     host: 'localhost', 
//     user: 'root', 
//     password: '1234',
//     database: 'trelloDB'
// })

// connection.connect((err) => {
//     if(err)
//     throw err;
//     console.log("connected to mysql")
// })

let config = function () {
    return  {
        database: {
            host: 'localhost', 
            user: 'root', 
            password: '1234',
            database: 'trelloDB',
            connectionLimit: 100            
        },
        timeout :20000
    }
}

module.exports = new config()

//module.exports = connection