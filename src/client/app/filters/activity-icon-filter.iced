###
	Converts activity types in proper font-awesome classes
###

angular.module("app").filter "activityIconFilter", ->
	(type) ->
		switch type
			when "youtube" then "fa-youtube"
			when "soundcloud" then "fa-music"
			when "link" then "fa-external-link"
			when "image" then "fa-picture-o"
			else "fa-pencil"
