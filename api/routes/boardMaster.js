const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")
//add new board
/**
 * @typedef Board
 * @property {string} board_title.required
 * @property {string} board_desc.required
 * @property {string} board_image.required
 * @property {string} createdBy.required
 * @property {string} board_type_id.required
 */

/**
 * @route POST /board
 * @param {Board.model} User.body.required
 * @group Users  
 */

router.post('/addBoard', checkAuth, (req, res) => {
    let body = APIBody.find(e => e.method == 'POST' && e.name == '/addBoard')
    if(!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("parameter not found...")
    }
    else {
        connection.getConnection((error, tempConnection) => {
            if(error) {
                console.log("Could not connect to the database...")
                res.status(504).json({
                    message: 'Could not process. Pleae try again..'
                })
            }
            else {
                tempConnection.query("INSERT into board_master (board_title, board_desc, createdOn, boardImage, createdBy) VALUES (?, ?, ?, UNIX_TIMESTAMP()*1000, ?, ?, ?)", [req])
            }
        })    
    }
})

module.exports = router