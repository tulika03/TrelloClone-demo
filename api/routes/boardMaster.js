const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")
const multer = require('multer')
const fs = require('fs')

let dir = `${__dirname}/../../uploads/boardImages`;
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, dir);
    },
    filename: function (req, file, cb) {
        fs.exists(`${dir}/${file.originalname}`, (exist) => {
            console.log(`exist `, exist);
            if (exist) {
                callback(new Error('File already exist'), file.originalname);
            }
            else {
                cb(null, file.originalname)
            }
        });
    }
});

const upload = multer({ storage: storage }).single('board_image')
//add new board
/**
 * @typedef Board
 * @property {string} board_title.required
 * @property {string} board_desc.required
 * @property {integer} board_type_id.required
 */

/**
 * @route POST /board/addBoard
 * @param {Board.model} Board.body.required
 * @group Board  
 */

router.post('/addBoard', checkAuth, (req, res) => {
    let body = APIBody.find(e => e.method == 'post' && e.name == '/addBoard')
    if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("parameter not found...")
    }
    else {
        console.log("req.decoded", req.decoded)
        connection.getConnection((error, tempConnection) => {
            if (error) {
                console.log("Could not connect to the database...")
                res.status(504).json({
                    message: 'Could not process. Pleae try again..'
                })
            }
            else {

                tempConnection.query("Select * from board_master where board_title=? AND createdBy = ? ;", [req.body.board_title, req.decoded.user_id], (error, rowData, fields) => {
                    tempConnection.pause()
                    if (error) {
                        console.log(error, "error")
                        res.status(504).json({
                            message: "Could not process. Please try again.."
                        })
                    }
                    else {

                        console.log("row data", rowData)
                        if (rowData.length == 0) {
                            tempConnection.resume();
                            tempConnection.query("INSERT into board_master (board_title, board_desc, boardImage, createdOn, createdBy, board_type_id) VALUES(?, ?, 3, UNIX_TIMESTAMP()*1000, ?, ?);", [req.body.board_title, req.body.board_desc, req.decoded.user_id, req.body.board_type_id], (err, rows, field) => {
                                tempConnection.release();

                                if (err) {
                                    console.log("DB error", err.message, err.sqlMessage)
                                    res.status(504).json({
                                        message: 'Unable to process. Please try again.....'
                                    })
                                }
                                else {
                                    if (rows.affectedRows == 1) {

                                        console.log("rows", rows)
                                        res.status(201).json({
                                            message: 'Board details inserted successfully....'
                                        })
                                    }
                                    else {
                                        res.status(500).json({
                                            message: 'board data could not be saved....'
                                        })
                                    }

                                }
                            })
                        }
                        else {
                            res.status(422).json({
                                message: 'Board Title already exists'
                            })
                        }
                    }
                })

            }
        })
    }
})


// get board list according to user id

/**
 * @route GET /board/boardsList
 * @group Board  
 */


router.get('/boardsList', checkAuth, (req, res, next) => {
    connection.getConnection((error, tempConnection) => {
        if (error) {
            console.log("db connection error", error)
            res.status(504).message({
                message: 'Unable to process. Please try again..'
            })
        }
        else {
            tempConnection.query("select bm.board_id, bm.board_title, bm.board_desc, bm.createdOn, bm.board_type_id, btm.board_type_name from board_master bm LEFT JOIN board_type_master btm on bm.board_type_id = btm.board_type_id AND bm.createdBy = ?", [req.decoded.user_id], (err, rows, fields) => {
                if (err) {
                    console.log("error", err)
                    res.status(504).json({
                        message: 'Unable to process. Please try again..'
                    })
                }
                else {
                    if (rows.length) {
                        res.status(200).json({
                            message: 'Data fetched successfully',
                            data: rows
                        })
                    }
                    else {
                        res.status(404).json({
                            message: 'No boards list found.'
                        })
                    }
                }

            })
        }
    })
})


// get board details 
// get board list according to user id

/**
 * @route GET /board/board_detail/{boardId}
 * @param {number} boardId.path.required
 * @group Board  
 */

router.get("/board_detail/:boardId", checkAuth, (req, res, next) => {
    connection.getConnection((error, tempConnection) => {
        if (error) {
            console.log("error", error)
            res.status(504).json({
                message: 'Unable to process. Please try again.'
            })
        }
        else {
            tempConnection.query("select bm.board_id, bm.board_title, bm.board_desc, bm.createdOn, bm.board_type_id, btm.board_type_name from board_master bm LEFT JOIN board_type_master btm on bm.board_type_id = btm.board_type_id where bm.board_id = ?", [req.params.boardId], (err, rows, fields) => {
                if (err) {
                    console.log("error", err)
                    res.status(504).json({
                        message: 'Unable to process. Please try again.'
                    })
                }
                else {
                    if (rows.length) {
                        res.status(200).json({
                            message: 'Data fetched successfully',
                            data: rows[0]
                        })
                    }
                    else {
                        res.status(404).json({
                            message: 'Board with the provided details does not exist.'
                        })
                    }
                }
            })
        }
    })
})

// delete a board
/**
 * @route DELETE /board/delete_board/{boardId}
 * @param {number} boardId.path.required
 * @group Board  
 */

 router.delete('/delete_board/:boardId', checkAuth, (req, res, next) => {
     connection.getConnection((error, tempConnection) => {
         if(error) {
             console.log("error to connect to db", error)
             res.status(504).message({
                message: 'Unable to process. Please try again..'
            })
         }
         else {
             tempConnection.query("delete from board_master where createdBy = ? and board_id = ?;", [req.decoded.user_id, req.params.boardId], (err, rows, field) => {
                 if(err) {
                     console.log("error", err)
                     res.status(504).message({
                        message: 'Unable to process. Please try again..'
                    }) 
                 }
                 else {
                        console.log("rows", rows)
                     if(rows.affectedRows > 0) {
                        res.status(200).json({
                            message: 'Data deleted successfully.',
                            data: rows[0]
                        })
                     }
                     else {
                        res.status(404).json({
                            message: 'Board with the provided details does not exist.'
                        })
                     }
                 }
             })
         }
     })
 })

module.exports = router