class SearchController < ApplicationController
  def index
  end

  def search_results
    @filtered_tickets, filtered_users, @filtered_orgs = nil
    @no_results = false
  	search_text = params[:search_text].strip
  	search_param = params[:search_param]
  	print params
  	@tickets = JSON.parse(File.read('public/tickets.json'))
  	@users = JSON.parse(File.read('public/users.json'))
  	@orgs = JSON.parse(File.read('public/organizations.json'))
    if search_param.eql?("all" || "tickets") || search_param.eql?("tickets")
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
    @no_results = (@filtered_tickets || @filtered_users || @filtered_orgs).empty? ? true : false
    render :partial => "search_results", :locals => { :ticket_results => @filtered_tickets, 
    	                                   :user_results => @filtered_users, 
                                         :org_results => @filtered_orgs,
                                         :no_results => @no_results }
  end
end
