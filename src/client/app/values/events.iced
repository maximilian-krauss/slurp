eventBase = "app.events"

angular.module("app").value "events",
	notification:
		broadcast: "#{eventBase}.notification.broadcast"

	auth:
		loggedin: "#{eventBase}.auth.loggedin"
		unauthorized: "#{eventBase}.auth.unauthorized"

	activity:
		new: "#{eventBase}.activity.new"
