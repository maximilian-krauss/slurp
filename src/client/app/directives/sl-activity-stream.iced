angular.module("app").directive "slActivityStream", (AuthService, StreamService, directiveTemplateUri) ->
	restrict: "E"
	templateUrl: "#{directiveTemplateUri}sl-activity-stream.html"
	scope: true,
	link: (scope, elem, attrs) ->
		scope.authenticated = AuthService.isAuthenticated
		scope.newActivityVM =
			title: ''
			content: ''
