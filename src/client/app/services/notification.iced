angular.module("app").service "NotificationService", ($rootScope, events) ->
	service = {}
	defaultArgs =
		type: ""
		title: ""
		message: ""
		timeout: 20

	_broadcastNotification = (args) ->
		extendedArgs = _.extend angular.copy(defaultArgs), args
		$rootScope.$emit events.notification.broadcast, angular.copy extendedArgs

	service.error = (args) ->
		_broadcastNotification _.extend type: "error", args

	service.success = (args) ->
		_broadcastNotification _.extend type: "success", args

	return service
