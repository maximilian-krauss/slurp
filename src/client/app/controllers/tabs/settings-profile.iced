angular.module("app").classy.controller
	name: "SettingsProfileCtrl"
	inject: [ "$scope", "SettingsService", "NotificationService", "dialogTemplateUri", "$modal" ]
	init: ->
		@$.form =
			vm: {}
			options:
				hideSubmit: true
			fields: [
				{
					key: "username"
					type: "text"
					label: "Username"
					disabled: true
				}
				{
					key: "firstName"
					type: "text"
					label: "Firstname"
				}
				{
					key: "lastName"
					type: "text"
					label: "Lastname"
				}
				{
					key: "slug"
					type: "text"
					label: "Slug (Markdown)"
				}
			]

		@SettingsService.getProfile()
			.then (result) =>
				@$.form.vm = result.data
				@$.$watch "form.vm", _.debounce(@_putChanges, 2000), true
			.catch (err) =>
				@NotificationService.error
					title: "Failed to fetch user data"
					message: err.data.message
					timeout: 10

	_putChanges: (data, oldOne) ->
		return if _(data).isEqual oldOne

		@SettingsService.putProfile @$.form.vm
			.then =>
				@NotificationService.success message: "Userprofile updated!", timeout: 2
			.catch (err) =>
				@NotificationService.error
					title: "Failed to update user profile"
					message: err.data.message
					timeout: 10

	changePassword: ->
		instance = @$modal.open
			controller: "ChangePasswordDialogCtrl"
			templateUrl: "#{@dialogTemplateUri}change-password.html"
			backdrop: "static"
			keyboard: false

		instance.result
			.then =>
				@NotificationService.success message: "Password updated!", timeout: 5
			.catch (err) =>
				if err
					@NotificationService.error
						title: "Failed to update password"
						message: err.data.message
						timeout: 10
