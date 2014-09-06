###
	Sherlock - Module to autodetect and render post content
###

_						= require "lodash"
marked			= require "marked"
ytInspector	= require "./inspectors/youtube"
scInspector	= require "./inspectors/soundcloud"

_renderMarkdown = (postRequestBody, cb) ->
	marked.setOptions
  	renderer: new marked.Renderer()
  	gfm: true
  	tables: true
  	breaks: false
  	pedantic: false
  	sanitize: true
  	smartLists: true

	await marked postRequestBody.content, defer err, renderedString
	if err
		return cb err

	postRequestBody.renderedContent = renderedString
	postRequestBody.type = "markdown"
	cb null, postRequestBody

module.exports.render = (postRequestBody, cb) ->
	inspectors = [
		new ytInspector postRequestBody
		new scInspector postRequestBody
	]
	inspector = _(inspectors).find (inspector) ->
		inspector.matches()

	if inspector?
		await inspector.render defer err, post
		return cb err, post


	_renderMarkdown postRequestBody, cb
