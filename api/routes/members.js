const express = require('express')
const router = express.Router()
let mysql = require('mysql')
let config = require('../../database/dbConnection')
let connection = mysql.createPool(config.database)

let checkAuth = require('../middleware/checkAuth')
const APIBody = require("../lib/APIbody")
const bodyCheck = require("../lib/bodyCheck")
const bcrypt = require('bcrypt')


/**
 * @typedef Member
 * @property {string} member_fullname.required
 * @property {string} member_email.required
 * @property {string} contact.required
 * @property {string} phoneCode.required
 * @property {string} password.required
 */

/**
 * @route POST /members/add
 * @param {Member.model} Member.body.required
 * @group Members  
 */

//post member details
router.post('/add', (req, res, next) => {
    let body = APIBody.find(e => e.method == 'post' && e.name == '/add');
    if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        res.status(400).json({ error: 1, message: 'Required parameter is missing....' })
    }
    else {
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if(err) {
                    res.status(500).json({
                        error: err
                    })
                }
                else {
                    connection.getConnection((error, tempConnection) => {
                        if (error) {
                            console.log(error, "error in connection..")
                        }
                        else {
                            let name = req.body.member_fullname
                            let email = req.body.member_email
                            let contact = req.body.contact
                            let phoneCode = req.body.phoneCode
                            let password = hash
                            tempConnection.query('INSERT into member_master(member_fullname, member_email, password, contact, phoneCode, confirmed, member_type, addedOn)VALUES(?, ?, ?, ?, ?, 1, "normal", UNIX_TIMESTAMP())'
                                , [name, email, password, contact, phoneCode], function (err, result) {
                                    if (err) throw err;
                                    else {
                                        console.log("Data inserted successfully...")
                                        res.status(201).json({
                                            message: "data inserted successfully....",
                                            data: result[0]
                                        })
                                    }
                                })
                            tempConnection.release()
                        }
                    })
                }
            })

    }
})

/**
* @route get /members
* @group Members
* @security JWT
*/

// get details of all the members
router.get('/', checkAuth, (req, res, next) => {
    connection.getConnection((err, tempConnection) => {
        if (err) {
            console.log("error in connection")
        }
        else {
            tempConnection.query('Select * from member_master', function (err, result) {
                if (err) throw err;
                else {
                    res.status(200).json({
                        message: "data fetched successfully....",
                        data: result[0]
                    })
                }

            })
            tempConnection.release()

        }
    })

});

// get member details on member id

/**
* @route get /members/{memberId}
* @param {number} memberId.path.required
* @security JWT
* @group Members
*/
router.get('/:memberId', checkAuth, (req, res, next) => {
    let memberId = req.params.memberId
    connection.getConnection((err, tempConnection) => {
        if (err) {
            console.log("error in connection")
        }
        else {
            tempConnection.query('Select * from member_master where member_id = ?', [memberId], function (err, result, field) {
                if (err) throw err;
                else {
                    console.log("data is", result);
                    res.status(200).json({
                        message: "data fetched successfully....",
                        data: result
                    })
                }
            })
            tempConnection.release()

        }
    })

});


//update member details

/**
* @typedef MemberEdit
* @property {string} member_fullname.required
* @property {string} member_email.required
* @property {string} contact.required
* @property {string} phoneCode.required
*/

/**
 * @route PUT /members/edit/{memberId}
 * @param {MemberEdit.model} MemberEdit.body.required
 * @param {number} memberId.path.required
 * @group Members  
 */

router.put('/edit/:memberId', checkAuth, (req, res, next) => {
    let memberId = req.params.memberId
    let body = APIBody.find(e => e.method == 'patch' && e.name == '/members/edit')
    if (!(bodyCheck.checkBody(req.body, body.body)).success) {
        console.log("parameter is missing....")
    }
    else {
        connection.getConnection((err, tempCon) => {
            if (err) {
                console.log("connection could not be established.....")
            }
            else {
                tempCon.query('UPDATE member_master set member_fullname = ?, member_email = ?, contact = ?, phoneCode = ? where member_id = ?',
                    [req.body.member_fullname, req.body.member_email, req.body.contact, req.body.phoneCode, req.params.memberId],
                    function (err, result) {
                        if (err) throw err;
                        else {
                            console.log("data is", result);
                            res.status(200).json({
                                message: "data updated successfully....",
                                data: result[0]
                            })
                        }
                    })
            }
        })
    }

})

module.exports = router;