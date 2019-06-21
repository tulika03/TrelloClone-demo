const express = require('express')
const router = express.Router()
const checkAuth = require('../middleware/checkAuth')
const mysql = require('mysql')
const config = require('../../database/dbConnection')
const connection = mysql.createPool(config.database)

/**
 * @typedef board_type
 * 
 */

 /**
 * @route Post /board-type
 * @group Board  
 */

router.post('/', (req, res, next) => {
       connection.getConnection((err, tempConn) => {
           if(err) {
               console.log("connection could not be established....")
               res.status(504).json({
                   message: 'Connection could not be esatblished'
               })
           }
           else {
               let types = [
                   ["1", "Personal"],
                   ["2", "Team"]
               ];

               tempConn.query('insert into board_type_master(board_type_id, board_type_name) values ?', [types], (err, result) => {
                    tempConn.release()  
                if(err) {
                       console.log("data could not be inserted")
                   }
                   else {
                       res.status(201).json({
                           message: 'Data inserted successfully...',
                           data: result
                       })
                   }
               })
           }
       }) 
    
})


/**
 * @typedef board_type
 */

 /**
 * @route get /board-type
 * @group Board  
 */
//get board types

router.get('/', (req, res, next) => {
    connection.getConnection((err, tempConn) => {
        if(err) {
            console.log(err ," Connection could not be established...")
        }
        else {
            tempConn.query("Select * from board_type_master", (err, result) => {
                tempConn.release()
                if(err) throw err;
                else {
                    console.log(result)
                    res.status(200).json({
                        message: "Data fetched successfully...",
                        data: result
                    })
                }
            })
        }
    })
})


module.exports = router