should		= require("chai").should()
sherlock	= require "../../sherlock"

youtubePost =
	content: "http://www.youtube.com/watch?v=UWb5Qc-fBvk"

soundcloudPost =
	content: "http://soundcloud.com/robin-schulz/robin-schulz-summerbreeze-dj-mix"

markdownPost =
	content: "This is **just** text"

describe "Sherlock", ->

	it "should have found sherlock", ->
		sherlock.should.be.a "Object"


	it "should detect and render youtube contents", (done) ->
		await sherlock.render youtubePost, defer err, post
		throw err if err

		post.should.have.property "type"
		post.type.should.equal "youtube"

		done()

	it "should detect and render soundcloud contents", (done) ->
		await sherlock.render soundcloudPost, defer err, post
		throw err if err

		post.should.have.property "type"
		post.type.should.equal "soundcloud"
		done()

	it "should detect and render markdown contents", (done) ->
		await sherlock.render markdownPost, defer err, post
		throw err if err

		post.should.have.property "type"
		post.type.should.equal "markdown"

		post.should.have.property "renderedContent"
		post.renderedContent.should.equal "<p>This is <strong>just</strong> text</p>\n"

		done()
