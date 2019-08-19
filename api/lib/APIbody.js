// Post and Put APIs body for checking missing keys
// Array of all API body  


module.exports = [
    {
        "method": 'post',
        "name": '/add',
        "body": {
            "member_fullname": "string",
            "member_email": "string",
            "contact": "string", 
            "phoneCode": 'string',
            "password": 'string'
        }
    },
    {
        "method": 'patch',
        "name": '/members/edit',
        "body": {
            "member_fullname": "string",
            "member_email": "string",
            "contact": "string", 
            "phoneCode": 'string'
        }
    },
    {
        "method": 'post',
        "name": '/teams/addTeam',
        "body": {
            "team_name": "string",
            "team_desc": "string",
            "team_mode": "string"
        }
    },
    {
        "method": 'post',
        "name": '/addBoard',
        "body": {
            "board_title": "string",
             "board_desc" : "string",
             "board_type_id": "integer"
        }
    },
    {
        "method": 'put',
        "name": '/edit_board_details',
        "body": {
             "board_desc" : "string",
             "board_type_id": "integer",
             "board_image": "integer"
        }
    },
    {
        "method": 'post',
        "name": '/team_member',
        "body": {
             "member_email" : "string",
             "addedBy": "integer"
        }
    },
    {
        "method": 'post',
        "name": '/addTeam',
        "body": {
            "team_name": "string",
            "team_desc": "string",
            "team_mode_id": "integer"
        }
    },
    {
        "method": 'post',
        "name": '/addList',
        "body": {
            "list_name": "string",
            "list_board_id": "string"
        }
    }
];