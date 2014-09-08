mongoose		= require "mongoose"
Schema			= mongoose.Schema


Application = new Schema
	title: 						type: String, default: "slurp:beta"
	description: 			type: String, default: ""
	teaserImageUrl: 	type: String, default: ""

module.exports.model = Application
