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
 * @property {string} member_email.required
 * @property {string} password.required
 */

/**
 * @route post /auth/login
 * @group Members
 * @param {Login.model} login.body.required
 */

//login 

router.post('/login', (req, res) => {
    if (typeof req.body.member_email == 'undefined' || req.body.member_email == null || req.body.password == null || typeof req.body.password == 'undefined') {
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
                console.log("member email",req.body.member_email)
                tempConnection.query('select member_id, member_email, password from member_master where member_email=?',
                    [req.body.member_email, ], (err, rows, field) => {
                        tempConnection.release()
                        if (err) {
                            console.log('Error : ', err);
                            let response = { error: 1, message: 'Unable to process. Try again' };
                            res.status(504).json(response);
                        }

                        else {
                            console.log("rows.length", rows.length, rows)
                            if(rows.length == 1) {
                                bcrypt.compare(req.body.password, rows[0].password, (err, result) => {
                                    if (err) {
                                        console.log("bcrypt eror block")
                                        return res.status(401).json({
                                            message: "Unable to process. Please try again..."
                                        })
                                    }
                                    else if (result) {
                                        const userLoginToken = jwt.sign(
                                            token = {
                                                member_id: rows[0].member_id,
                                                member_fullname: rows[0].member_fullname,
                                                member_email: rows[0].member_email
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
                                    else if(!result){
                                        console.log("bcrypt else block")
                                        return res.status(401).json({
                                            message: "Authentication failed"
                                        })
                                    }
    
                                })
                            } 
                            else {
                                return res.status(401).json({
                                    message: 'You are unauthorized to login....'
                                })
                            }
                   
                        }
                    })
            }
        })
    }
})


/**
 * @typedef forgotPassword
 * @property {string} member_email.required
 */

/**
 * @route post /auth/forgotPassword
 * @group Members
 * @param {forgotPassword.model} forgotPassword.body.required
 */

// forgot password

router.post('/forgotPassword', (req, res, next) => {
    if (req.body.member_email == null || typeof req.body.member_email == 'undefined') {
        console.log("Parameter not found...")
        res.status(400).json({ error: 1, message: 'Required parameter is missing' });
    }
    else {
        connection.getConnection((err, tempConn) => {
            if (err) {
                console.log("connection error ", err.message);
                let response = { error: 1, message: 'Unable to connect to the DB. Try again' };
                res.status(504).json(response);
            }
            else {
                let verification_key = verficationKey();
                tempConn.query('update member_master set verification_key = ? where member_email = ?;', [verification_key, req.body.member_email], function (error, rows, field) {
                    tempConn.query('select member_id, member_email from member_master where member_email = ?;', [req.body.member_email], (err, result) => {
                        tempConn.release();
                        if (err) {
                            console.log("email not found....")
                            let response = { error: 1, message: 'Invalid Email' };
                            res.status(401).json(response);
                        }
                        else {
                            let link = `${config.baseUrl}\\auth\\reset_password\\${req.body.member_email}\\${verification_key}`;
                            sgMail.setApiKey(process.env.SENDGRID_API_KEY);
                            const msg = {
                                to: req.body.member_email,
                                from: 'test2@gmail.com',
                                subject: 'Reset password Trello',
                                text: 'Please reset your password by clicking on the given link ' + link
                            }
                            sgMail.send(msg)
                            res.status(200).json({ success: 1, data: {}, message: 'Mail sent to your registerd email id.' });
                        }
                    })
                })

            }
        })
    }
})


/**
 * @typedef resetPassword
 * @property {string} member_email.required
 * @property {string} verification_key.required
 * @property {string} password.required
 */

/**
 * @route put /auth/resetPassword
 * @group Members
 * @param {resetPassword.model} resetPassword.body.required
 */

// resetPassword
router.put('/resetPassword', (req, res, next) => {
    if (req.body.password == null || typeof req.body.password == 'undefined' ||
        req.body.member_email == null || typeof req.body.member_email == 'undefined') {
        console.log("parameter is missing")
    }
    else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
            if(err) {
                res.status(500).json({
                    error: err
                })
            }
            else {
                connection.getConnection((err, tempConn) => {
                    if (err) {
                        console.log("connection could not be established....")
                        res.status(504).json({
                            message: 'Connection could not be established with the database....'
                        })
                    }
                    else {
                        tempConn.query('UPDATE `member_master` SET `password` = ? WHERE `member_email` = ? AND `verification_key` = ?', 
                        [hash, req.body.member_email, req.body.verification_key], (error, rows, field) => {
                            tempConn.release();
                            if (error) {
                                console.log('Error : ',error);
                                let response = {error: 1, message: 'Unable to process. Please try again'};
						        res.status(504).json(response);
                            }
                            else {
                                if(rows.affectedRows != 0) {
                                    console.log("password changed successfully..")
                                    res.status(200).json({
                                        message: 'Password updated successfully.'
                                    })
                                }
                                else {
                                    console.log('Authorization code invalid');
							        let response = {error: 1, message: 'Authorization code invalid'};
							        res.status(401).json(response);
                                }
                               
                            }
                        })
                    }
                })
            }
        })

    }
})
// verfication key generation
function verficationKey() {
    let options = {
        min: 1000,
        max: 999999,
        integer: true
    }

    return (rn(options));
}

module.exports = router