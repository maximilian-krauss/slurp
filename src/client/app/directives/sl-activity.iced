angular.module("app").directive "slActivity", (directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-activity.html"
	scope:
		model: "@?"
	link: (scope, elem) ->
