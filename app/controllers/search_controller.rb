class SearchController < ApplicationController
  def index
  end

  def search_results
  	search_text = params[:search_text]
  	search_param = params[:search_param]
  	print params
  	@tickets = JSON.parse(File.read('public/tickets.json'))
  	@users = JSON.parse(File.read('public/users.json'))
  	@orgs = JSON.parse(File.read('public/organizations.json'))
  	# print "\nThis prints all tickets: \n"
    # @filtered_tickets = @tickets.map {|key, value| print value if value.include?(search_text)}
    @filtered_tickets = @tickets.select {|ticket| ticket.to_s.downcase.include?(search_text.downcase)}
    @filtered_users = @users.select {|user| user.to_s.downcase.include?(search_text.downcase)}
    @filtered_orgs = @orgs.select {|org| org.to_s.downcase.include?(search_text.downcase)}
 	# respond_to do |format|
 		 # format.js
       # format.js  { render :partial => "search_results", :formats => [:html, :js, :json, :url_encoded_form], :locals => { :search_results => @tickets } }
       # format.json  { render :json => { :search_results => @tickets } }
     # end
    render :partial => "search_results", :locals => { :ticket_results => @filtered_tickets, 
    	:user_results => @filtered_users, :org_results => @filtered_orgs  }
  end
end
