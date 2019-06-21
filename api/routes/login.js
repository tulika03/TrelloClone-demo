const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const mysql = require('mysql')
const config = require("../../database/dbConnection")
const connection = mysql.createPool(config.database)
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")
const jwt = require('jsonwebtoken')
const sgMail = require('@sendgrid/mail')
const env = require('../../env')
let rn = require('random-number')
/**
 * @typedef Login
 * @property {string} user_email.required
 * @property {string} password.required
 */

/**
 * @route post /auth/login
 * @group Users
 * @param {Login.model} login.body.required
 */

//login 

router.post('/login', (req, res, next) => {
    if (typeof req.body.user_email == 'undefined' || req.body.user_email == null || req.body.password == null || typeof req.body.password == 'undefined') {
        console.log("Username parameter not found")
        res.status(400).json({
            message: 'Username or password is missing.....'
        })
    }
    else {
        connection.getConnection((err, tempConnection) => {
            if (err) {
                console.log("Connection could not be establed with the database.")
            }
            else {
                tempConnection.query('select user_id, user_email, password from user_master where user_email = ?', 
                [req.body.user_email], (err, rows, field) => {
                    tempConnection.release()
                    if (err) {
                        console.log('Error : ', err);
						let response = {error: 1, message: 'Unable to process. Try again'};
						res.status(504).json(response);
                    }

                    else {
                        bcrypt.compare(req.body.password, rows[0].password, (err, result) => {
                            if (err) {
                                console.log("bcrypt eror block")
                                return res.status(401).json({
                                    message: "Authentication failed"
                                })
                            }
                            else if (result) {
                                const userLoginToken = jwt.sign(
                                    token = {
                                        user_id: rows[0].user_id,
                                        user_name: rows[0].user_name,
                                        user_email: rows[0].user_email
                                    },
                                    process.env.JWT_KEY,
                                    {
                                        expiresIn: 200000
                                    }
                                )

                                return res.status(200).json({
                                    message: 'User logged in successfully.....',
                                    token: userLoginToken
                                })
                            }

                        })
                    }
                })
            }
        })
    }
})


/**
 * @typedef forgotPassword
 * @property {string} user_email.required
 */

/**
 * @route post /auth/forgotPassword
 * @group Users
 * @param {forgotPassword.model} login.body.required
 */

// forgot password

router.post('/forgotPassword', (req, res, next) => {
    if(req.body.user_email == null || typeof req.body.user_email == 'undefined') {
        console.log("Parameter not found...")
        res.status(400).json({error : 1 ,message : 'Required parameter is missing'});	
    }
    else {
        connection.getConnection((err, tempConn) => {
            if(err) {
                console.log("connection error ",err.message);
				let response = {error: 1, message: 'Unable to connect to the DB. Try again'};
				res.status(504).json(response);
            }
            else {
                let verification_key = verficationKey();
                tempConn.query('update user_master set verification_key = ? where user_email = ?;', [verification_key, req.body.user_email], function(error, rows, field) {
                        tempConn.query('select user_id, user_email from user_master where user_email = ?;', [req.body.user_email], (err, result) => {
                            tempConn.release();
                            if(err) {
                                console.log("email not found....")
                                let response = {error: 1, message: 'Invalid Email'};
                                res.status(401).json(response);
                            }
                            else {
                                let link = `${config.baseUrl}\\auth\\reset_password\\${req.body.user_email}\\${verification_key}`;        
                                sgMail.setApiKey(process.env.SENDGRID_API_KEY);
                                const msg = {
                                    to: 'zk7676@gmail.com',
                                    from :'tulika312@gmail.com',
                                    subject: 'Reset password Trello',
                                    text: 'Please reset your password by clicking on the given link <br> <p>' + link + '</p>' 
                                }
                                sgMail.send(msg)
                                res.status(200).json({success: 1, data: {} , message: 'Mail sent to your registerd email id.'});
                            }
                        })       
                })
     
            }
        })
    }
})


function verficationKey() {
    let options = {
        min: 1000,
        max: 999999,
        integer: true
    }

    return(rn(options));
}

module.exports = router