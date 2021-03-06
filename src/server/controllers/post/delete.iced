###
	[DELETE] Post Api Controller - Delets an existing post (kinda obvious...)
	Auth: cookie
###

db						= require "../../database"
envi 					= require "../../environment-helper"
azure					= require "azure"
socketEvents	= require "../../socket-events"

_removeAssociatedUpload = (postUid, cb) ->
	await db.uploadModel.findOne referenceType: "post", referenceUid: postUid, defer err, upload
	if err or not upload
		return cb err

	blobService = azure.createBlobService()
	await blobService.deleteBlob envi.azure.container, upload.blobPath, defer err
	if err
		return cb err

	await db.uploadModel.remove uid: upload.uid, defer err

	return cb err # Looks awkward

module.exports = (io) ->
	return (req, res) ->
		await _removeAssociatedUpload req.params.id, defer err
		if err
			return res.status(400).send message: err.message

		await db.postModel.remove uid: req.params.id, defer err
		if err
			return res.status(400).send()

		io.emit socketEvents.post.deleted, req.params.id

		res.status(200).send()
