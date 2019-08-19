const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")


//add new list

/**
 * @typedef List
 * @property {string} list_name.required
 * @property {integer} list_board_id.required
 */

/**
 * @route POST /list/addList
 * @param {List.model} List.body.required
 * @group List  
 */


 router.post('/addList', checkAuth, (req, res, next) => {
    let body = APIBody.find(e => e.method == 'post' && e.name == '/addList');
    if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("parameter missing.");
    }
    else {
        connection.getConnection((error, tempCon) => {
            if(error) {
                console.log("error", error);
                res.status(504).json({
                    message: 'Unable to process. Please try again.'
                });
            }
            else {
                tempCon.query("select list_position from list_master where list_board_id = ? order by list_position DESC limit 1;", [req.body.list_board_id], (err, rows, field) => {
                    tempCon.pause();
                    if(err) {
                        console.log("err", err);
                        res.status(504).json({
                            message: 'Unable to process. Please try again.'
                        });
                    }
                    else {
                        let count = 0;
                        console.log("count check", rows);
                        if(rows.length == 0) {
                           count = 16384;
                        }
                        else {
                            count = rows[0].list_position + 16384;
                        }
                        console.log("count check 1", count);
                        tempCon.resume();
                        tempCon.query("INSERT into list_master(list_name, createdOn ,createdBy, list_board_id, list_position) VALUES (?,  UNIX_TIMESTAMP()*1000, ?, ?, ?)", 
                        [req.body.list_name, req.decoded.member_id, req.body.list_board_id, count], (err1, rows1, field1)=> {
                            tempCon.release();
                            if(err1) {
                                console.log("err1", err1);
                                res.status(504).json({
                                    message: 'Unable to process. Please try again.'
                                });
                            }
                            else {
                                if(rows1.affectedRows > 0) {
                                    res.status(201).json({
                                        message: 'List added successfully.'
                                    })
                                }
                                else {
                                    res.status(504).json({
                                        message: 'Unable to process. Please try again.'
                                    });
                                }
                            }
                        })

                    }
                })
            }
        })
    }
 })

 module.exports = router;