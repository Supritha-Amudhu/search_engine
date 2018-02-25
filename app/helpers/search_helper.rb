module SearchHelper
	def assign_item_values(search_text, search_param)
		if search_param.eql?("all") || search_param.eql?("tickets")
	      if search_text.eql?("") 
	        @filtered_tickets = @tickets.select {|ticket| ticket.has_value?("")} 
	      else
	        @filtered_tickets = @tickets.select {|ticket| ticket.to_s.downcase.include?(search_text.downcase)} 
	      end
	    end
	    if search_param.eql?("all") || search_param.eql?("users")
	      if search_text.eql?("") 
	        @filtered_users = @users.select {|user| user.has_value?("")} 
	      else
	        @filtered_users = @users.select {|user| user.to_s.downcase.include?(search_text.downcase)}
	      end
	    end
	    if search_param.eql?("all") || search_param.eql?("organizations")
	      if search_text.eql?("") 
	        @filtered_orgs = @orgs.select {|org| org.has_value?("")} 
	      else
	        @filtered_orgs = @orgs.select {|org| org.to_s.downcase.include?(search_text.downcase)}
	      end
	    end
	end
end
