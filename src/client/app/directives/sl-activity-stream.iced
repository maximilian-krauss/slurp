angular.module("app").directive "slActivityStream", (AuthService, StreamService, PostService, NotificationService, directiveTemplateUri) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
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
			PostService.create(scope.newActivityVM)
				.then (result) ->
					scope.activities.splice 0,0, result.data
					_resetNewActivityForm()
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
