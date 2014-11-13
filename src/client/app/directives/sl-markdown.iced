angular.module("app").directive "slMarkdown", ($sce, markdownOptions) ->
	restrict: "AE"
	scope:
		slMarkdown: "@"
	link: (scope, elem, attrs) ->
		marked.setOptions markdownOptions
		if attrs.slMarkdown
			scope.$watch "slMarkdown", (value) ->
				elem.html marked value
			, true
		else
			elem.html $sce.trustAsHtml marked elem.html()
