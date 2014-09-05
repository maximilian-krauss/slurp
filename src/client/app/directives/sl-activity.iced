angular.module("app").directive "slActivity", ($sce, directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-activity.html"
	scope:
		model: "="
	link: (scope, elem) ->
		scope.renderHtmlBody = () ->
    	return $sce.trustAsHtml(scope.model.rendered);

		scope.renderDate = () ->
			return moment(scope.model.date).fromNow()
