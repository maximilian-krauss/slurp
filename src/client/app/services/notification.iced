angular.module("app").service "NotificationService", ($rootScope, events) ->
	service = {}
	defaultArgs =
		type: "info"
		title: ""
		message: ""
		timeout: 10

	_broadcastNotification = (args) ->
		extendedArgs = _.extend defaultArgs, args
		$rootScope.$emit events.notification.broadcast, extendedArgs

	service.error = (args) ->
		_broadcastNotification _.extend type: "error", args

	service.warn = (args) ->
		_broadcastNotification _.extend type: "warning", args

	return service
