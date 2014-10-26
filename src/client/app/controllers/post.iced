angular.module("app").classy.controller
	name: "PostCtrl"
	inject: [ "$scope", "$location", "$rootScope", "postModel", "RealtimeService", "socketEvents" ]

	init: ->
		@$.model = @postModel.data
		@$rootScope.title = @postModel.data.title

		@RealtimeService.on @socketEvents.post.deleted, @_postDeleted

		@$.$on "$destroy", =>
			@RealtimeService.removeListener @socketEvents.post.deleted, @_postDeleted

	_postDeleted: (uid) ->
		@$location.path("/") if uid is @$.model.uid
