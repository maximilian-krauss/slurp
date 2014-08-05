app = angular.module "app", [
		"ngRoute"
		"classy"
	]

app.config ($routeProvider, $locationProvider) ->
	templateUri = "/static/html/views"
	$locationProvider.html5Mode true


	$routeProvider
		.when "/", controller: "HomeCtrl", templateUrl: [templateUri, "home.html"].join("/")
