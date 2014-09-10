angular.module("app").directive "slActivity", ($sce, directiveTemplateUri, PostService, AuthService) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-activity.html"
	scope:
		model: "="
	link: (scope, elem) ->
		scope.removed = false
		scope.isAuthenticated = AuthService.isAuthenticated

		scope.renderHtmlBody = () ->
    	return $sce.trustAsHtml(scope.model.rendered);

		scope.renderDate = () ->
			return moment(scope.model.date).fromNow()

		scope.delete = () ->
			PostService.delete scope.model.uid
				.then () ->
					scope.removed = true
