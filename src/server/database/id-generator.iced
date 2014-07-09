crypto		= require "crypto"
shortHash	= 7

module.exports.compute = () ->
	seed = crypto.randomBytes 20
	hash = crypto.createHash("sha1").update(seed).digest("hex")
	hash.substring 0, shortHash
