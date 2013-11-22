module ApplicationHelper

	#returns the full title on a per-page basis
	def full_title(page_tile)
		base_tile = "Ruby on Rails Tutorial Sample App"
		if page_tile.empty?
			base_tile
		else
			"#{base_tile} | #{page_tile}"
		end
	end
end
