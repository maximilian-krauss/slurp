app = angular.module "app", [
		"ngRoute"
		"classy"
	]

window.app = app

app.config ($routeProvider, $locationProvider) ->
	$locationProvider.html5Mode true
