angular.module("app").directive "slProfile", (directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: [ directiveTemplateUri, "sl-profile.html" ].join("/")
	scope: true
	controller: ($scope) ->
		console.log "hi"
