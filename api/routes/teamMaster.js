const express = require('express')
const router = express.Router();
const checkAuth = require('../middleware/checkAuth')
const APIbody = require('../lib/APIbody')
const bodyCheck = require('../lib/bodyCheck')
//add new board

router.post('/addTeam', checkAuth, (req, res) => {
    
})