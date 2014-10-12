apiBase = "/api/0/"

angular.module("app").value "endpoints",
	user: "#{apiBase}user"
	post: "#{apiBase}posts"
	stream: "#{apiBase}stream"
	settings: "#{apiBase}settings"
	upload: "#{apiBase}upload"
