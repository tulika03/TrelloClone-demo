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
            if (error) {
                console.log("error", error);
                res.status(504).json({
                    message: 'Unable to process. Please try again.'
                });
            }
            else {
                tempCon.query("select list_position from list_master where list_board_id = ? order by list_position DESC limit 1;", [req.body.list_board_id], (err, rows, field) => {
                    tempCon.pause();
                    if (err) {
                        console.log("err", err);
                        res.status(504).json({
                            message: 'Unable to process. Please try again.'
                        });
                    }
                    else {
                        let count = 0;
                        console.log("count check", rows);
                        if (rows.length == 0) {
                            count = 16384;
                        }
                        else {
                            count = rows[0].list_position + 16384;
                        }
                        console.log("count check 1", count);
                        tempCon.resume();
                        tempCon.query("INSERT into list_master(list_name, createdOn ,createdBy, list_board_id, list_position) VALUES (?,  UNIX_TIMESTAMP()*1000, ?, ?, ?)",
                            [req.body.list_name, req.decoded.member_id, req.body.list_board_id, count], (err1, rows1, field1) => {
                                tempCon.release();
                                if (err1) {
                                    console.log("err1", err1);
                                    res.status(504).json({
                                        message: 'Unable to process. Please try again.'
                                    });
                                }
                                else {
                                    if (rows1.affectedRows > 0) {
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

//change list position

/**
 * @route PUT /list/change_pos/{listId}/{pos}
 * @param {integer} listId.path.required
 * @param {integer} pos.path.required
 * @group List  
 */


router.put('/change_pos/:listId/:pos', (req, res, next) => {
    connection.getConnection((error, tempCon) => {
        if (error) {
            console.log("error", error);
            res.status(504).json({
                message: 'Unable to process. Please try again.'
            });
        }
        else {
            console.log("param", req.params.listId)
            tempCon.query("select * from list_master where list_id=?", [req.params.listId], (err, rows, field) => {
                tempCon.pause();
                if (err) {
                    console.log("err", err);
                    res.status(504).json({
                        message: 'Unable to process. Please try again.'
                    });
                }
                else {
                    if (rows.length > 0) {
                        let query = "";
                        query = "select (@row_number:=@row_number + 1) AS index_number, list_id, list_name, list_position, list_board_id from list_master, (select @row_number:=0) as t where list_board_id=? order by list_position ASC;"
                        tempCon.resume()
                        tempCon.query(query, [rows[0].list_board_id], (err1, rows1, field2) => {
                            tempCon.pause();
                            if (err1) {
                                console.log("error", err1)
                                res.status(504).json({
                                    message: 'Unable to process. Please try again.'
                                })
                            }
                            else {
                                let lists = rows1
                                let current_position = lists.filter(e => e.list_id == req.params.listId);
                                if (current_position[0].index_number != +req.params.pos) {                                    
                                    let new_position = 0;
                                    if (+req.params.pos == 1) {
                                        new_position = (lists[0].list_position / 2);
                                    }
                                    else if (+req.params.pos == parseInt(lists.length)) {
                                        new_position = lists[lists.length - 1].list_position + 16384;
                                    }
                                    else {                                      
                                        if (current_position[0].index_number < +req.params.pos) {
                                            console.log("check cond where current is < pos")
                                            let prev_position = lists.filter(e => e.index_number == +req.params.pos + 1);
                                            console.log("prev position", prev_position)
                                            let next_position = lists.filter(e => e.index_number == +req.params.pos);
                                            console.log("next position", next_position)
                                            new_position = (prev_position[0].list_position + next_position[0].list_position) / 2;
                                        }
                                        else {
                                            console.log("check cond where current is > pos")
                                            let prev_position = lists.filter(e => e.index_number == +req.params.pos - 1);
                                            let next_position = lists.filter(e => e.index_number == +req.params.pos);
                                            new_position = (prev_position[0].list_position + next_position[0].list_position) / 2;
                                        }
                                    }
                                    console.log("new position is", new_position)
                                    tempCon.resume();
                                    tempCon.query("Update `list_master` set `list_position` = ? where `list_id` = ?; select (@row_number:=@row_number + 1) AS index_number, list_id, list_name, list_board_id from list_master, (select @row_number:=0) as t where list_board_id=? order by list_position ASC;",
                                        [new_position, req.params.listId, rows[0].list_board_id], (err2, rows2, field2) => {
                                            tempCon.release();
                                            if (err2) {
                                                console.log("error", err2)
                                                res.status(500).json({
                                                    message: 'Unable to process. Please try again.'
                                                })
                                            }
                                            else {
                                                res.status(200).json({
                                                    message: "Position changed successfully",
                                                    data: rows2[1]
                                                })
                                            }
                                        })
                                }
                                else {
                                    res.status(400).json({
                                        message: 'current position and new position cannot be same'
                                    })
                                }
                            }
                        })
                    }
                    else {
                        res.status(404).json({
                            message: 'Data with provided id not found'
                        });
                    }

                }
            })
        }
    })
})


module.exports = router;