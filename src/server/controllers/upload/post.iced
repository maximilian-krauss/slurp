###
	[POST] Api Controller
	Processes requests which uploads binary stuff
	Auth: cookie
###

_						= require "lodash"
moment			= require "moment"
azure				= require "azure"
fs					= require "fs"
path				= require "path"
multiparty	= require "multiparty"
envi 				= require "../../environment-helper"
crypto			= require "crypto"
db 					= require "../../database"
uploadPath	= [ "uploads", moment().format("YYYY/MM/DD") ].join "/"

_toFullAzureUrl = (filename) ->
	"https://#{envi.azure.account}.blob.core.windows.net/#{envi.azure.container}/#{filename}"

_fromAzureUrl = (url) ->
	url.replace "https//#{envi.azure.account}.blob.core.windows.net/#{envi.azure.container}/", ""

_randomizeFilename = (filename) ->
	extension = path.extname filename
	seed = crypto.randomBytes 20
	hash = crypto.createHash("sha1").update(seed).digest("hex")
	"#{hash}#{extension}"

_removeUpload = (path, cb) ->
	await fs.unlink path, defer err
	if err
		console.error "Failed to remove temp file: #{path}"

	cb null

module.exports = (req, res) ->
	form = new multiparty.Form()
	await form.parse req, defer err, fields, files
	if err
		return res.status(400).send message: err.message

	if files?.file?.length is 0
		return res.status(400).send message: "No file provided"

	file = _(files.file).first()
	blobPath = [ uploadPath, _randomizeFilename file.originalFilename ].join "/"
	blobService = azure.createBlobService()
	stream = fs.createReadStream file.path

	await blobService.createBlockBlobFromStream envi.azure.container, blobPath, stream, file.size, defer err
	if err
		return res.status(400).send message: err.message

	stream.close()

	await _removeUpload file.path, defer err
	if err
		return res.status(500).send err.message

	uploadModel = new db.uploadModel
		blobPath: blobPath
		blobUri: _toFullAzureUrl blobPath
		filename: file.originalFilename

	await uploadModel.save defer err
	if err
		return res.status(400).send message: err.message

	res.status(201).send uploadModel
