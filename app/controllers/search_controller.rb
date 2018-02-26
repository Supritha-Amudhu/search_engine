class SearchController < ApplicationController

  include SearchHelper

  before_action :parse_files
  before_action :initialize_variables, :only => :search_results

  # Method to get all the search fields for Tickets, Users and Organizations
  def index
    @search_keys = Hash.new
    @search_keys[:tickets] = @tickets.first.keys if (@tickets && !@tickets.empty?)
    @search_keys[:users] = @users.first.keys if (@users && !@users.empty?)
    @search_keys[:organizations] = @organizations.first.keys if (@organizations && !@organizations.empty?)
  end

  # Method to retrieve search results for different search terms and parameters
  # no_results - checks if results for tickets, users or organizations has values or not
  def search_results
  	search_text = params[:search_text].strip
    search_ticket_param = params[:ticketSearchField].downcase
    search_user_param = params[:userSearchField].downcase
    search_organization_param = params[:organizationSearchField].downcase

    if(search_ticket_param.eql?("none") && search_user_param.eql?("none") && search_organization_param.eql?("none"))
      message = "Please select a search parameter."
    end

    @filtered_tickets = assign_item_values(@tickets, search_ticket_param, search_text)
    @filtered_users = assign_item_values(@users, search_user_param, search_text)
    @filtered_organizations = assign_item_values(@organizations, search_organization_param, search_text)

    @no_results = ( is_item_empty?(@filtered_tickets) && is_item_empty?(@filtered_users) && is_item_empty?(@filtered_organizations) ) ? true : false
    render :partial => "search_results", :locals => { :ticket_results => @filtered_tickets, 
    	                                   :user_results => @filtered_users, 
                                         :org_results => @filtered_organizations,
                                         :no_results => @no_results,
                                         :message => message}
  end

  private

    # Variables initialized to default values
    def initialize_variables
      @filtered_tickets, @filtered_users, @filtered_organizations = []
      @no_results = false
    end

    # File parsed everytime during search because it can be edited anytime
    def parse_files
      @tickets = JSON.parse(File.read('public/tickets.json'))
      @users = JSON.parse(File.read('public/users.json'))
      @organizations = JSON.parse(File.read('public/organizations.json'))
    end

end
