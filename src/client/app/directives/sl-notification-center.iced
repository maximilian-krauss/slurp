angular.module("app").directive "slNotificationCenter", ($rootScope, $timeout, events, directiveTemplateUri) ->
	restrict: "E"
	replace: true
	templateUrl: "#{directiveTemplateUri}sl-notification-center.html"
	scope: true
	link: (scope, elem, attrs) ->
		scope.notifications = []
		identifier = 0

		scope.closeNotification = (id) ->
			notification = _(scope.notifications).find (n) -> n.id is id
			if notification?
				scope.notifications.splice(scope.notifications.indexOf(notification), 1)

		$rootScope.$on events.notification.broadcast, (ev, notification) ->
				notification.id = ++identifier

				switch notification.type
					when "success" then notification.class = "alert-success"
					when "error" then notification.class = "alert-danger"
					when "warning" then notification.class = "alert-warning"
					else notification.class = "alert-info"

				scope.notifications.push notification

				if(notification.timeout)
					$timeout(
						->
							scope.closeNotification notification.id
						, notification.timeout * 1000
					)
