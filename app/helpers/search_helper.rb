module SearchHelper

	# Retrieve search results for Tickets, Users and Organiztions based on the list item chosen, the list parameter (fields) chosen,
	# and the search term used.
	def assign_item_values(search_list, search_param, search_text)
		if(search_param.eql?("none"))
			filtered_values = []
		else
			if search_text.eql?("") 
		        filtered_values = search_list.select {|ticket| ticket.has_value?("")} 
		    else
				filtered_values = search_list.select {|list_item| list_item["#{search_param}"].to_s.downcase.include?(search_text.downcase)} 
			end
		end
	end

	# Returns true if the search results for tickets, users or organizations if empty based on the item passed
	def is_item_empty?(item)
		item && item.empty?
	end

end
