const router = require('express').Router()
const config = require('../../database/dbConnection')
const mysql = require('mysql')
const connection = mysql.createPool(config.database)
const multer = require('multer')
const fs = require('fs')
const easyzip = require('easy-zip')

let dir = `${__dirname}/../../uploads/boardImages`;
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, dir);
    },
     filename: function(req, file, callback) {
        fs.exists(`${dir}/${file.originalname}`,(exist)=>{
            console.log(`exist `,exist);
            if(exist){
                callback(new Error('File already exists.'),file.originalname);                    
            } else {
                callback(null,file.originalname);                    
            }
        });     
     }
});
const upload = multer({ storage: storage}).array('boardImages', 5)

/**
 * @route post /images/uploadImage
 * @group Files
 * @param {file} boardImages.formData.required
 * @security JWT
 */

 router.post('/uploadImage', (req, res, next) => {
     upload(req, res, (err) => {
         if(!err) {
            let filesList= [];
           
            filesList = req.files.filter(e=> e.filename.length > 70).map(e => e.filename)
            if(filesList.length > 0) {
                res.status(424).json({
                    message: 'file names are larger than 70',
                    filesArray: filesList
                })
            }
            else {
                connection.getConnection((error, tempConnection) => {
                    if(error) {
                        console.log("error", error)
                        res.status(504).json({
                            message: 'Unable to process. Please try again..'
                        })
                    }
                    else {
                        let filesNames = []
                        filesNames = req.files.map( e =>  e.filename)
                        tempConnection.query("insert into board_images_options (image_name, image_type) values(?, 'admin image')", [filesNames], (err, rows, fields) => {
                            if(err) {
                                console.log("error", error);
                                res.status(504).status({
                                    message: 'Unable to process. Please try again.'
                                })
                            }
                            else {
                                if(rows.affectedRows > 0) {
                                    console.log("rows data", rows)
                                    res.status(201).json({
                                        message: 'Images uploaded successfully.'
                                    })
                                }
                                else {
                                    res.status(500).json({
                                        message: "Data could not be saved. Please try again."
                                    })
                                }
                            }
                        })
                    }
                })
            }
         }
     })
    
 })

 // download multiple files

//router.get("/backgroundImages")

module.exports = router