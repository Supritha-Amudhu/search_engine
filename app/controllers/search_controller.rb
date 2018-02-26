class SearchController < ApplicationController

  include SearchHelper

  before_action :initialize_variables, :only => :search_results

  def search_results
  	search_text = params[:search_text].strip
  	search_param = params[:search_param].downcase
    assign_item_values(search_text, search_param)
    @no_results = ( is_item_empty?(@filtered_tickets) && is_item_empty?(@filtered_users) && is_item_empty?(@filtered_orgs) ) ? true : false
    render :partial => "search_results", :locals => { :ticket_results => @filtered_tickets, 
    	                                   :user_results => @filtered_users, 
                                         :org_results => @filtered_orgs,
                                         :no_results => @no_results }
  end

  private

    def initialize_variables
      # Variables initialized to default values
      @filtered_tickets, @filtered_users, @filtered_orgs = []
      @no_results = false

      # File parsed everytime during search because it can be edited anytime
      @tickets = JSON.parse(File.read('public/tickets.json'))
      @users = JSON.parse(File.read('public/users.json'))
      @orgs = JSON.parse(File.read('public/organizations.json'))
    end

end
