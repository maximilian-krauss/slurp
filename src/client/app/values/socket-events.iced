socketEventBase = "socket"

angular.module("app").value "socketEvents",
	post:
		created: "#{socketEventBase}:post:created"
		deleted: "#{socketEventBase}:post:deleted"
