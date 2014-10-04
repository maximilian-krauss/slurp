angular.module("app").directive "slNotificationCenter", ($rootScope, $timeout, events, directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-notification-center.html"
	scope: true
	link: (scope, elem, attrs) ->

		$rootScope.$on events.notification.broadcast, (ev, notification) ->
				notificationMessage = notification.message
				if notification.title
					notificationMessage = "#{notification.title}: #{notification.message}"

				alertify.log notificationMessage, notification.type, notification.timeout * 1000
