angular.module("app").classy.controller
	name: "HeaderCtrl"
	inject: [ "$scope" ]
	init: ->
		@$.title = "App title"
		@$.description = "App description"
		@$.heading =
			"background-image": "url('http://blog.krauss.io/content/images/2014/Jul/2014-07-19-22-05-52.jpg')"
