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

module.exports = (req, res) ->
	blobService = azure.createBlobService()
	form = new multiparty.Form()

	form.on "part", (part) ->
		if part.filename
			filename = [ uploadPath, _randomizeFilename part.filename ].join "/"
			size = part.byteCount

			await blobService.createBlockBlobFromStream envi.azure.container, filename, part, size, defer err
			if err
				return res.status(400).send message: err.message

			uploadModel = new db.uploadModel
				blobPath: filename
				blobUri: _toFullAzureUrl filename
				filename: part.filename

			await uploadModel.save defer err
			if err
				return res.status(400).send message: err.message


			return res.status(201).send uploadModel

		else
			return res.status(400).send message: "No filename provided"

	form.on "err", (err) ->
		return res.status(400).send message: err.message

	form.parse req
