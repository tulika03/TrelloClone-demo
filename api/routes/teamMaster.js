const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const APIbody = require('../lib/APIbody')
const bodyCheck = require('../lib/bodyCheck')
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)


//add new team

/**
 * @typedef Team
 * @property {string} team_name.required
 * @property {string} team_desc.required
 * @property {integer} team_mode_id.required
 */

/**
 * @route POST /team/addTeam
 * @param {Team.model} Team.body.required
 * @group Team  
 */


router.post('/addTeam', checkAuth, (req, res) => {
        let body = APIbody.find(e => e.method == 'post' && e.name == '/addTeam')
        if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("Parameter missing");
        }
        else {
        connection.getConnection((error, tempConnection) => {
            if (error) {
                console.log("error to connect to DB.", error)
            }
            else {
                    if(req.body.team_mode_id == 0) {
                        req.body.team_mode_id = 1;
                    }
                tempConnection.query("INSERT into team_master (team_name, team_desc, createdOn, createdBy, team_mode_id) VALUES (?, ?, UNIX_TIMESTAMP()*1000, ?, ?)",
                    [req.body.team_name, req.body.team_desc, req.decoded.member_id, req.body.team_mode_id], (err1, rows1, fields1) => {
                        tempConnection.release();
                        if (err1) {
                            console.log("error", err1)
                            res.status(504).json({
                                message: 'Unable to process. Please try again.'
                            })
                        }   
                        else {
                            if (rows1.affectedRows > 0) {
                                res.status(201).json({
                                    message: 'Team created successfully.'
                                })
                            }
                        }
                    })
                 }
            })
        }
    })


// get teams list

router.get('/teamsList', checkAuth, (req, res, next) => {

    connection.getConnection((error, tempConnection)=> {
        if(error) {
            console.log("error", error)
            res.status(504).json({
                message: 'Unable to process. Please try again.'
            })
        }
        else {
          tempConnection.query("Select t.team_id, t.team_name, t.team_desc, t.createdBy, tm.team_mode_type from team_master t inner join team_mode_master tm on t.team_mode_id = tm.team_mode_id where t.createdBy = ?", 
            [req.decoded.member_id], (err, rows, field) => {
                if(err) {
                    console.log("err", err)
                    res.status(504).json({
                        message: 'Unable to process. Please try again.'
                    })
                }
                else {
                    if(rows.length > 0) {
                        res.status(200).json({
                            data: rows
                        })
                    }
                    else {
                        res.status(200).json({
                            message: 'No teams available for the user.'
                        })
                    }
                }
            })
        }
    })
})

// get team detail by id

    module.exports = router;