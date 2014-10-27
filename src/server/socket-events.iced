_socketEventBase = "socket"

module.exports =
	post:
		created: "#{_socketEventBase}:post:created"
		deleted: "#{_socketEventBase}:post:deleted"
		hitcountIncreased: "#{_socketEventBase}:post:hitcountIncreased"
