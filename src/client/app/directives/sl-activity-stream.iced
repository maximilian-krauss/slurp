angular.module("app").directive "slActivityStream", (AuthService, StreamService, PostService, NotificationService, directiveTemplateUri) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
		scope.authenticated = AuthService.isAuthenticated
		scope.activities = []
		scope.newActivityVM =
			title: ''
			content: ''

		streamOffset = 0

		scope.submitPost = ->
			PostService.create(scope.newActivityVM)
				.then (data) ->
					console.log data
				.catch (err) ->
					NotificationService.error message: err.data.message

		scope.fetchActivities = () ->
			StreamService.fetch(streamOffset)
				.then (result) =>
					_(result.data).each (activity) ->
						scope.activities.push(activity)

				.catch (err) =>
					console.log err


		scope.fetchActivities()
