###
	[DELETE] Upload API Controller
	Delets an uploaded file from database and blobservice
	Auth: Cookie
###

db			= require "../../database"
azure		= require "azure"
envi 		= require "../../environment-helper"

module.exports = (req, res) ->
	await db.uploadModel.findOne uid: req.params.id, defer err, upload
	if err
		return res.status(400).send message: err.message

	if not upload
		return res.status(404).send()

	blobService = azure.createBlobService()
	await blobService.deleteBlob envi.azure.container, upload.blobPath, defer err
	if err
		return res.status(400).send message: err.message

	await db.uploadModel.remove uid: req.params.id, defer err
	if err
		return res.status(400).send message: err.message


	res.status(200).send()
