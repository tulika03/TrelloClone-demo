const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const APIbody = require('../lib/APIbody')
const bodyCheck = require('../lib/bodyCheck')
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)
//add new board

router.post('/addTeam', checkAuth, (req, res) => {
    if(!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("Parameter missing");
    }
    else {
        connection.getConnection((error, tempConnection) => {
            if(error) {
                console.log("error to connect to DB.", error)
            }
            else {

                tempConnection.query("SELECT * from member_master where member_email=?", [req.body.member_email], (err, rows, fields) => {
                    if(err) {
                        console.log("Error", error)
                        res.status(504).json({
                            message: 'Unable to process. Please try again.'
                        })
                    }
                    else {
                        if(rows.length) {
                            res.status(422).json({
                                message: 'This email id already exists.'
                            })
                        }
                        else {
                            tempConnection.query("INSERT into member_master (member_email, addedOn, addedBy) VALUES(?, UNIX_TIMESTAMP()*1000, ?",
                             [req.body.member, req.decoded.member_id], (err1, rows1, fields1) => {
                                if(err1) {
                                    console.log("error", err1)
                                    res.status(504).json({
                                        message: 'Unable to process. Please try again.'
                                    })
                                }
                                else {
                                    if(rows1.affectedRows > 0) {
                                        res.status(201).json({
                                            message: 'Member has been sent an invitation'
                                        })  
                                    }
                                }
                            })
                        }
                    }
                })

                
            }
        })
    }
})