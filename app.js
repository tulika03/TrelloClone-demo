const express = require('express')
const app = express();
const morgan = require('morgan')
const bodyParser = require('body-parser');
const expressSwagger = require('express-swagger-generator')(app)
const cors = require('cors')
let rateLimit = require('express-rate-limit')

// routes
const userRoutes = require('./api/routes/users')
const loginRoutes = require('./api/routes/login')
const boardTypeRoute = require('./api/routes/boardType')

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
                name: 'x-access-token'
            }
        },
        security: [
          {
            JWT: []
          }
        ]
    },
    basedir: __dirname, //app absolute path
    files: ['./api/routes/**/*.js'] //Path to the API handle folder
}

expressSwagger(options);

morgan.token('id', function getId(req) {
  return req.id
})

morgan.token('req', function(req) {
  return JSON.stringify(req.body)
})

let loggerFormat = 'Logger -- :id [:date[web]] ":method :url" :status :response-time :req '

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 1000
});

app.use(apiLimiter);
app.use(morgan('dev'))

app.use(morgan(loggerFormat, {
  skip: function(req, res) {
    return res.statusCode >=400
  },
  stream: process.stderr
}))
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(cors())

//app.use() acts as a middleware
app.use('/login', loginRoutes)
app.use('/users', userRoutes);
app.use('/board-type', boardTypeRoute)

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