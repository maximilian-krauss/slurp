angular.module("app").classy.controller
	name: "LoginCtrl"
	inject: [ "$scope", "$location", "AuthService", "NotificationService" ]
	init: ->
		@$.form =
			vm: {}
			options:
				submitCopy: "Login"
			fields: [
				{
					key: "username"
					type: "text"
					label: "Username"
					required: true
				}
				{
					key: "password"
					type: "password"
					label: "Password"
					required: true
				}
			]

	login: ->
		@AuthService.login(@$.form.vm)
			.then (data) =>
				@location.path("/")
			.catch =>
				@NotificationService.error message: "Login failed!"
