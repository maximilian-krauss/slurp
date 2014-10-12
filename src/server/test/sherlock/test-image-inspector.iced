should			= require("chai").should()
imInspector	= require "../../sherlock/inspectors/image"

pngImgHttpUrl 	= "http://www.imgserver.com/img/foo.png"
pngImgHttpsUrl 	= "https://www.imgserver.com/img/foo.png"

gifImgHttpsNoWwwUrl = "https://imgserver.com/img/bar.gif"
gifImgHttpNoWwwUrl = "http://imgserver.com/img/bar.gif"

invalidUrl = "https://www.imgserver.com/foo/bar"

describe "Sherlock", ->
	describe "Image", ->

		it "should build an valid inspector", ->
			inspector = new imInspector content: pngImgHttpUrl
			inspector.should.be.a "Object"

		it "should detect an image (http, www, png)", ->
			inspector = new imInspector content: pngImgHttpUrl
			match = inspector.matches()
			match.should.be.equal true

		it "should detect an image (https, www, png)", ->
			inspector = new imInspector content: pngImgHttpsUrl
			match = inspector.matches()
			match.should.be.equal true

		it "should detect an image (http, no www, gif)", ->
			inspector = new imInspector content: gifImgHttpNoWwwUrl
			match = inspector.matches()
			match.should.be.equal true

		it "should detect an image (https, no www, gif)", ->
			inspector = new imInspector content: gifImgHttpsNoWwwUrl
			match = inspector.matches()
			match.should.be.equal true

		it "should return false if content is not an image url", ->
			inspector = new imInspector content: invalidUrl
			match = inspector.matches()
			match.should.be.equal false
