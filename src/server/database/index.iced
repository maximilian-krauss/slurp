_						= require "lodash"
mongoose		= require "mongoose"
envi 				= require "../environment-helper"

options             =
	server:
		socketOptions:
			keepAlive: 1

_connect = ->
	mongoose.connect "mongodb://#{envi.mongo.user}:#{envi.mongo.password}@#{envi.mongo.server}", options

_connect()

mdb = mongoose.connection
mdb.on "error", console.error.bind(console, "connection fuckup:")
mdb.on "open", ->
	console.log "Database connection established!"
mdb.on "close", ->
	console.error "Database fucked up, trying to reconnect"
	_connect()


module.exports.userModel = mongoose.model "User", require("./user").model
module.exports.postModel = mongoose.model "Post", require("./post").model
module.exports.applicationModel = mongoose.model "Application", require("./application").model
module.exports.uploadModel = mongoose.model "Upload", require("./upload").model
