angular.module("app").directive "slActivityStream", (AuthService, StreamService, PostService, NotificationService, directiveTemplateUri) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
		scope.authenticated = AuthService.isAuthenticated
		scope.newActivityVM =
			title: ''
			content: ''

		scope.submitPost = ->
			PostService.create(scope.newActivityVM)
				.then (data) ->
					console.log data
				.catch (err) ->
					NotificationService.error message: err.data.message
