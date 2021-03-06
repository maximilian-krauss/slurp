angular.module("app").classy.controller
	name: "SettingsSiteCtrl"
	inject: [ "$scope", "SettingsService", "NotificationService", "DialogService", "PostService" ]
	init: ->
		@$.appUid = "app-ignore"
		@$.form =
			vm: {}
			options:
				hideSubmit: true
			fields: [
				{
					key: "title"
					type: "text"
					label: "Title"
					required: true
				}
				{
					key: "description"
					type: "text"
					label: "Description"
					required: true
				}
			]

		@SettingsService.getApplication()
			.then (result) =>
				@$.form.vm = result.data
				@$.$watch "form.vm", _.debounce(@_putChanges, 2000), true
			.catch (result) =>
				@NotificationService.error
					title: "Failed to fetch application data"
					message: result.data.message
					timeout: 20

	_putChanges: (data, oldOne) ->
		return if _(data).isEqual oldOne

		@SettingsService.putApplication(data)
			.then =>
				@NotificationService.success message: "Settings updated!", timeout: 2
			.catch (result) =>
				@NotificationService.error
					title: "Failed to update settings"
					message: result.data.message
					timeout: 10

	rerenderAllPosts: ->
		@DialogService.blockUi
			title: "Rerendering"
			message: "Rerendering all posts, this could take a bit ..."
			promise: @PostService.rerender [ ]
		.then =>
			@NotificationService.success message: "All posts rerendered!"
		.catch (err) =>
			@NotificationService.error
				title: "Failed to rerender posts"
				message: err.data.message
				timeout: 10
