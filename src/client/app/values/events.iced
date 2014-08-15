eventBase = "app.events"

angular.module("app").value "events",
	notification:
		broadcast: "#{eventBase}.notification.broadcast"
