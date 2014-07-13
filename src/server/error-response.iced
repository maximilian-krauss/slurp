module.exports.send = (res, status, message) ->
	message = message or ""
	status = status or 500

	res.send status, status: status, message: message
