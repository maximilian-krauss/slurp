module.exports.send = (res, status, message) ->
	message = message or ""
	status = status or 500

	res.status(status).send status: status, message: message
