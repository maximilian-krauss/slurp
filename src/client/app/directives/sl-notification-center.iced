angular.module("app").directive "slNotificationCenter", ($rootScope, events, directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-notification-center.html"
	scope: true
	link: (scope, elem, attrs) ->
		$rootScope.$on events.notification.broadcast, (ev, args) ->
			console.log ev, args
