let router = require('express').Router();
let bodyParser = require('body-parser')
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));

let jwt = require('jsonwebtoken')
require('../../env')

router.use(function(req, res, next) {
    // check header or url parameters or post parameters for token
    let token = req.headers['x-acces-token']
    console.log("token is: ", token)

    // decode token

    if(token) {
        jwt.verify(token, process.env.JWT_KEY, function(err, decoded) {
            if(err) {
                return res.json({ error: 1, message: 'Failed to authenticate token.'})
            }
            else {
                console.log("decoded", decoded)
                req.decoded = decoded;    
                next();
            }
        })
    }
    else {
        // if there is no token
        // return an error
        return res.status(403).send({ success: 0,message: 'No token provided.'});
    }
})

module.exports = router