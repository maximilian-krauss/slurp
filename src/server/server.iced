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
#db						= require "./database"
responseTime	= require "response-time"
pkg						= require "../package"
favicon				= require "serve-favicon"
app						= express()


app.set "port", process.env.port or 3000
app.use logger { format: 'dev' }
app.use compress()
#app.use favicon path.join __dirname, "../public/images/favicon.ico"
app.use responseTime()
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use cookieParser "TODO: replace me with some more random string"
app.use session { secret: "TODO: replace me again with more randomness", key: "session", cookie: { maxAge: 86400000 } } # <- 1d
app.use passport.initialize()
app.use passport.session()

router.use "/static", express.static path.join(__dirname, "../public")
router.use "/static-vendor", express.static path.join(__dirname, "../bower_components")

app.use route.config router

http.createServer(app).listen app.get("port"), ->
  console.log "slurp up and running on 127.0.0.1:#{app.get "port"}"
