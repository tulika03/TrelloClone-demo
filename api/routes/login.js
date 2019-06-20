const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const mysql = require('mysql')
const config = require("../../database/dbConnection")
const connection = mysql.createPool(config.database)
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")
const jwt = require('jsonwebtoken')

/**
 * @typedef Login
 * @property {string} user_email.required
 * @property {string} password.required
 */

/**
 * @route post /login
 * @group Users
 * @param {Login.model} login.body.required
 */

//login 

router.post('/', (req, res, next) => {
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





module.exports = router