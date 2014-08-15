app = angular.module "app", [
		"ngRoute"
		"classy"
		"formly"
	]

app.config ($routeProvider, $locationProvider) ->
	templateUri = "/static/html/views"
	$locationProvider.html5Mode true


	$routeProvider
		.when "/", controller: "HomeCtrl", templateUrl: [templateUri, "home.html"].join("/")
		.when "/login", controller: "LoginCtrl", templateUrl: [templateUri, "login.html"].join("/")


app.value "directiveTemplateUri", "/static/html/directives/"
