angular.module("app").factory "RealtimeService", ($rootScope) ->
	socket = io.connect()
	service =
		on: (eventName, callback) ->
			socket.on eventName, callback

		removeListener: (eventName, callback) ->
			socket.removeListener(eventName, callback);

		emit: (eventName, data, callback) ->
			socket.emit eventName, data, ->
				args = arguments
				$rootScope.$apply ->
					if callback then callback.apply socket, args

	return service
