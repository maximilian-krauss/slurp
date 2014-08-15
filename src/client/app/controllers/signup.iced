angular.module("app").classy.controller
	name: "SignupCtrl"
	inject: [ "$scope", "$location", "AuthService", "NotificationService" ]
	init: ->
		@$.form =
			vm: {}
			options:
				submitCopy: "Signup"
			fields: [
				{
					key: "username"
					label: "Username"
					type: "text"
					required: true
				}
				{
					key: "email"
					label: "E-Mail"
					type: "email"
					required: true
				}
				{
					key: "password"
					label: "Password"
					type: "password"
					required: true
				}
				{
					key: "authToken"
					label: "Auth-Token"
					type: "text"
					required: true
				}
			]

	signup: ->
		@AuthService.signup @$.form.vm
			.then =>
				@$location.path "/login"
			.catch (err) =>
				console.log err
				@NotificationService.error title: "Signup failed", message: err.data.message
