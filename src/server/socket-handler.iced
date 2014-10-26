module.exports = (io) ->

	io.on "connection", (socket) ->
		console.log "Got a new socket connection"
