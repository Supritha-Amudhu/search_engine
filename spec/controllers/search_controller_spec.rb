require File.dirname(__FILE__) + '/../spec_helper'
require 'rails_helper'
require 'search_helper'

describe SearchController, :type => :controller do
	render_views 

	describe "GET index" do
		xit "loads the Index page" do
			get :index
			response.should render_template(:index)
			response.status.should be 200
		end
	end

	describe "Search for a term" do
		it "should display results for a search term under the category 'All'" do
			debugger
			expect(controller).to receive(:initialize_variables)
			get :search_results, :params => {:search_text => "", :search_param => "All"}
			debugger
			# @filtered_tickets.should be []
			response.status.should be 200
		end
	end
end
