_						= require "lodash"
mongoose		= require "mongoose"

MONGO_DB_USER       = process.env["MONGO_DB_USER"]
MONGO_DB_PASSWORD   = process.env["MONGO_DB_PASSWORD"]
MONGO_DB_SERVER     = process.env["MONGO_DB_SERVER"]

options             =
	server:
		socketOptions:
			keepAlive: 1

_connect = ->
	mongoose.connect "mongodb://#{MONGO_DB_USER}:#{MONGO_DB_PASSWORD}@#{MONGO_DB_SERVER}", options

_connect()

mdb = mongoose.connection
mdb.on "error", console.error.bind(console, "connection fuckup:")
mdb.on "open", ->
	console.log "Database connection established!"
mdb.on "close", ->
	console.error "Database fucked up, trying to reconnect"
	_connect()


module.exports.userModel = mongoose.model "User", require("user").model
module.exports.postModel = mongoose.model "Post", require("post").model
