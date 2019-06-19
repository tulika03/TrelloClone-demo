const express = require('express')
const router = express.Router()
let mysql = require('mysql')
let config = require('../../database/dbConnection')
let connection = mysql.createPool(config.database)
//const connection = require('../../database/dbConnection');
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")



/**
 * @typedef User
 * @property {string} user_name.required
 * @property {string} user_email.required
 * @property {string} contact.required
 * @property {string} phoneCode.required
 * @property {string} user_address.required
 * @property {string} password.required
 * @property {string} city.required
 * @property {string} state.required
 * @property {string} country.required
 */

/**
 * @route POST /users
 * @param {User.model} User.body.required
 * @group Users  
 */

 //post user details
router.post('/',  (req, res, next) => {
    console.log("sdusaydutytds", req.body)
    let body = APIBody.find(e => e.method == 'post' && e.name == '/users');
    if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("parameter not found....")
        res.status(400).json({ error: 1, message: 'Required parameter is missing....' })
    }
    else {
        connection.getConnection((error, tempConnection) => {
            if (error) {
                console.log(error, "error in connection..")
            }
            else {
                let name = req.body.user_name
                let email = req.body.user_email
                let contact = req.body.contact
                let phoneCode = req.body.phoneCode
                let password = req.body.password
                let address = req.body.user_address
                let city = req.body.city
                let state = req.body.state
                let country = req.body.country
                console.log("email is", email)
                tempConnection.query('INSERT into user_master(user_name, user_email, password, contact, phoneCode, user_address, city, state, country)VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)'
                    , [name, email, password, contact, phoneCode, address, city, state, country], function (err, result) {
                        if (err) throw err;
                        else {
                            console.log("Data inserted successfully...")
                        }
                    })
                    tempConnection.release()

                res.status(201).json({
                    message: "data inserted successfully...."
                })
            }
        })
   }
})

/**
* @route get /users
* @group Users
*/
// get details of all the users
router.get('/', (req, res, next) => {
    connection.getConnection((err, tempConnection) => {
        if(err) {
            console.log("error in connection")
        } 
       else {
           tempConnection.query('Select * from user_master')
           tempConnection.release()
           res.status(200).json({
            message: "data fetched successfully...."
        })
       }
    })

  });
  

module.exports = router;