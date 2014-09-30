angular.module("app").classy.controller
	name: "SettingsSiteCtrl"
	inject: [ "$scope", "SettingsService" ]
	init: ->
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
				{
					key: "teaserImageUrl"
					type: "text"
					label: "Teaser Image Url"
				}
			]

		@SettingsService.getApplication()
			.then (result) =>
				@$.form.vm = result.data
				@$.$watch "form.vm", _.debounce(@_putChanges, 2000), true

	_putChanges: (data) ->
		@SettingsService.putApplication(data)
			.then ->
				console.log "data updated"
			.catch ->
				console.log "failed to update data"
