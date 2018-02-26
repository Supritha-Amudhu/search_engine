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
			get :search_results, :params => {:search_text => "", :search_param => "All"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
		end

		it " should return search results for a search term with no search list chosen " do
			search_text = "test"
			get :search_results, :params => {:search_text => search_text, :search_param => "All"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
		end

		it " should return search results for a search term 'zendesk' with search parameter 'All' " do
			search_text = 'zendesk'
			get :search_results, :params => {:search_text => search_text, :search_param => "All"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return search results for a search term 'incident' with search parameter 'Tickets' " do
			search_text = 'incident'
			get :search_results, :params => {:search_text => search_text, :search_param => "Tickets"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return search results for a search term 'organizations' with search parameter 'Organizations' " do
			search_text = 'organizations'
			get :search_results, :params => {:search_text => search_text, :search_param => "Organizations"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return search results for a search term 'users' with search parameter 'Users' " do
			search_text = 'users'
			get :search_results, :params => {:search_text => search_text, :search_param => "Users"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /#{search_text}/
		end

		it " should return search results for a random search term 'harrypotterharrypotterharrypotter' with search parameter 'All' " do
			search_text = 'harrypotterharrypotterharrypotter'
			get :search_results, :params => {:search_text => search_text, :search_param => "All"}
			response.status.should be 200
			response.should render_template(:partial => '_search_results')
			response.body.should =~ /Sorry, no results found./
		end

	end
end
