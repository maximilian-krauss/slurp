###
	Converts activity types in proper font-awesome classes
###

angular.module("app").filter "activityIconFilter", ->
	(type) ->
		switch type
			when "youtube" then "fa-youtube"
			else "fa-pencil"
