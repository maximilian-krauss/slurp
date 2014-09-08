angular.module("app").directive "slActivityStream", (AuthService, StreamService, PostService, NotificationService, directiveTemplateUri) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
		scope.isStreamBusy = false
		scope.isSubmitBusy = false
		scope.noMorePosts = false
		scope.authenticated = AuthService.isAuthenticated
		scope.activities = []
		scope.newActivityVM =
			title: ""
			content: ""

		streamOffset = 0

		_resetNewActivityForm = () ->
			scope.newActivityVM.title = ""
			scope.newActivityVM.content = ""

		scope.submitPost = ->
			scope.isSubmitBusy = true
			
			PostService.create(scope.newActivityVM)
				.then (result) ->
					scope.activities.splice 0,0, result.data
					_resetNewActivityForm()
				.catch (err) ->
					NotificationService.error message: err.data.message
				.finally ->
					scope.isSubmitBusy = false

		scope.fetchActivities = () ->
			return if scope.isStreamBusy or scope.noMorePosts

			scope.isStreamBusy = true
			StreamService.fetch(streamOffset++)
				.then (result) =>
					_(result.data).each (activity) ->
						scope.activities.push(activity)

					if result.data.length is 0
						scope.noMorePosts = true

					scope.isStreamBusy = false
				.catch (err) =>
					console.log err


		scope.fetchActivities()

		$(window).scroll =>
			if $(window).scrollTop() is ($(document).height() - $(window).height())
				scope.fetchActivities()
