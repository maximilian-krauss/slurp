angular.module("app").classy.controller
	name: "SettingsCtrl"
	inject: [ "$scope", "tabsTemplateUri" ]
	init: ->
		@$.siteTabUri = "#{@tabsTemplateUri}settings-site.html"
		@$.profileTabUri = "#{@tabsTemplateUri}settings-profile.html"
