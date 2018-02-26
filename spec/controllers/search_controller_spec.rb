require File.dirname(__FILE__) + '/../spec_helper'
require 'rails_helper'
require 'search_helper'

describe SearchController, :type => :controller do
	render_views 

	describe " GET index " do
		it " loads the Index page " do
			get :index
			response.status.should be 200
			response.should render_template(:index)			
		end
	end

	describe " Search for a term " do

		it " should return search results for an empty search term " do
			get :search_results, :params => {:search_text => "", :ticketSearchField => "url", :userSearchField => "None", :organizationSearchField => "None" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
		end

		it " should return search results for a search term with no search list chosen " do
			search_text = "test"
			get :search_results, :params => {:search_text => search_text, :ticketSearchField => "None", :userSearchField => "None", :organizationSearchField => "None" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /Please select a search parameter./
		end

		it " should return search results for a search term 'zendesk' with search list 
			'Tickets, Users, Organizations' with 'url' chosen for all " do
			search_text = 'zendesk'
			get :search_results, :params => {:search_text => search_text, :ticketSearchField => "url", :userSearchField => "url", :organizationSearchField => "url" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return high priority tickets " do
			search_text = 'high'
			get :search_results, :params => {:search_text => search_text, :ticketSearchField => "Priority", :userSearchField => "None", :organizationSearchField => "None" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return a user with the name - Rose Newton " do
			search_text = 'Rose Newton'
			get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return all Non-profit organizations " do
			search_text = 'Non profit'
			get :search_results, :params => {:search_text => search_text, :organizationSearchField => "Details", :userSearchField => "None", :ticketSearchField => "None"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return search results for a ticket ID with white spaces to the left and right " do
			search_text = '436bf9b0-1147-4c0a-8439-6f79833bff5b'
			get :search_results, :params => {:search_text => "         "+search_text+"       ", :ticketSearchField => "_ID", :userSearchField => "None", :organizationSearchField => "None" }
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return user with an unavailable name value 'harrypotterharrypotterharrypotter' " do
			search_text = 'harrypotterharrypotterharrypotter'
			get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /Sorry, no results found./
		end

		it " should handle errors and print them on the console when a search parameter is not passed " do
			get :search_results, :params => {:search_text => "", :userSearchField => "Name", :ticketSearchField => "None"}
			response.body.should =~ /error/
		end

	end
end
