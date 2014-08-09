express				= require "express"
router				= express.Router()
compress			= require "compression"
bodyParser		= require "body-parser"
cookieParser	= require "cookie-parser"
session				= require "express-session"
passport			= require "passport"
LocalStrategy	= require("passport-local").Strategy
logger				= require "morgan"
http					= require "http"
path					= require "path"
dotenv				= require("dotenv").load()
route					= require "./route"
db						= require "./database"
responseTime	= require "response-time"
pkg						= require "../package"
favicon				= require "serve-favicon"
envi          = require "./environment-helper"
app						= express()

# Authentication config
passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  await db.userModel.findById id, defer err, user
  done null, user

passport.use new LocalStrategy (username, password, done) ->
  await db.userModel.findOne { username: username, isActive: true }, defer err, user
  if(err)
    return done err

  if not user? or not user.isActive
    return done null, false

  await user.comparePassword password, defer err, isMatch
  if(err)
    return done err

  return done null, if isMatch then user else false


app.set "port", process.env.PORT or 3000
app.use logger "dev", {}
app.use compress()
#app.use favicon path.join __dirname, "../public/images/favicon.ico"
app.use responseTime()
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use cookieParser envi.server.cookieSecret
app.use session { resave: true, saveUninitialized: true, secret: envi.server.sessionSecret, key: "session", cookie: { maxAge: 86400000 } } # <- 1d
app.use passport.initialize()
app.use passport.session()

router.use "/static", express.static path.join(__dirname, "../public")
router.use "/static-vendor", express.static path.join(__dirname, "../bower_components")


# Authentication routes
router.post "/api/user/login", (req, res, next) ->
  passport.authenticate("local", (err, user, info) ->
    return next(err)  if err
    return res.send(400, "Access denied, better luck next time")  unless user
    req.logIn user, (err) ->
      return next(err)  if err
      res.send 200, "go for it"

    return
  ) req, res, next

router.post "/api/user/logout", (req, res) ->
  req.logout()
  res.send "OK"


app.use route.config router

http.createServer(app).listen app.get("port"), ->
  console.log "slurp up and running on 127.0.0.1:#{app.get "port"}"
