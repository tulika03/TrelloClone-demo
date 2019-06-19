const express = require('express')
const app = express();
const morgan = require('morgan')
const bodyParser = require('body-parser');
const expressSwagger = require('express-swagger-generator')(app)
const cors = require('cors')

const userRoutes = require('./api/routes/users')

let options = {
    swaggerDefinition: {
        info: {
            description: 'This is a sample server',
            title: 'trllo Clone',
            version: '1.0.0',
        },
        host: 'localhost:3001',
        basePath: '/',
        produces: [
            "application/json",
            "application/xml"
        ],
        securityDefinitions: {
            JWT: {
                type: 'apiKey',
                in: 'header',
                name: 'Authorization',
                description: "",
            }
        },
    },
    basedir: __dirname, //app absolute path
    files: ['./api/routes/**/*.js'] //Path to the API handle folder
}

expressSwagger(options);

app.use(morgan('dev'))
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(cors())

//app.use() acts as a middleware
app.use('/users', userRoutes);

app.use((req, res, next) => {
    console.log("check 404")
    const error = new Error('Not found');
    error.status = 404;
    next(error)
  })
  
  app.use((error, req, res, next) => {
    console.log("check 500")
    res.status(error.status || 500)
    res.json({
      error: {
        message: error.message
      }
    })
  })
module.exports = app;