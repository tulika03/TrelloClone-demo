// Post and Put APIs body for checking missing keys
// Array of all API body  


module.exports = [
    {
        "method": 'post',
        "name": '/users',
        "body": {
            "user_name": "string",
            "user_email": "string",
            "contact": "string", 
            "phoneCode": 'string',
            "user_address": "string",
            "password": 'string',
            "city": "string",
            "state": "string", 
            "country": "string"
        }
    },
    {
        "method": 'patch',
        "name": '/users',
        "body": {
            "user_name": "string",
            "user_email": "string",
            "contact": "string", 
            "phoneCode": 'string',
            "user_address": "string",
            "city": "string",
            "state": "string", 
            "country": "string"
        }
    }
];