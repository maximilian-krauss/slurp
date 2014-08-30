###
	Stream Controller
	---
	Handles all stream related stuff, such as pagination etc.
	Url Schema: /api/$version$/stream/:offset
###

module.exports =
	get: require "./get"
