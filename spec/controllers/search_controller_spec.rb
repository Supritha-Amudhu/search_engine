require File.dirname(__FILE__) + '/../spec_helper'
require 'rails_helper'

describe SearchController, :type => :controller do
	render_views 

	describe " GET index " do

		it " loads the Index page - Response 200 " do
			get :index
			expect(response.status).to eq 200
		end

		it " loads the Index page - Render template " do
			get :index
			expect(response).to render_template(:index)			
		end

	end

	describe " Search for a term " do

		describe " Request should return search results for an empty search term " do

			it " should have the response code 200 " do
				get :search_results, :params => {:search_text => "", :ticketSearchField => "url", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				get :search_results, :params => {:search_text => "", :ticketSearchField => "url", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response).to render_template(:partial => '_search_results')
			end

		end

		describe " Request should return search results for a search term with no search list chosen " do

			it " should have the response code 200 " do
				search_text = "test"
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "None", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = "test"
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "None", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = "test"
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "None", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.body).to match /Please select a search parameter./
			end

		end

		describe " Request should return search results for a search term 'zendesk' with search list 
					'Tickets, Users, Organizations' with 'url' chosen for all - All 3 Lists chosen " do

			it " should have the response code 200 " do
				search_text = 'zendesk'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "url", :userSearchField => "url", :organizationSearchField => "url" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = 'zendesk'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "url", :userSearchField => "url", :organizationSearchField => "url" }
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = 'zendesk'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "url", :userSearchField => "url", :organizationSearchField => "url" }
				expect(response.body).to match /#{search_text}/
			end

		end

		describe " Request should return high priority tickets - Validating ticket results with priority " do

			it " should have the response code 200 " do
				search_text = 'high'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "Priority", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = 'high'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "Priority", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = 'high'
				get :search_results, :params => {:search_text => search_text, :ticketSearchField => "Priority", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.body).to match /#{search_text}/
			end

		end

		describe " Request should return a user with the name - Rose Newton - Validating Ticket results for a particular user " do

			it " should have the response code 200 " do
				search_text = 'Rose Newton'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = 'Rose Newton'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None" }
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = 'Rose Newton'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None" }
				expect(response.body).to match /#{search_text}/
			end

		end

		describe " Request should return all Non-profit organizations - Validating Organization results " do

			it " should have the response code 200 " do
				search_text = 'Non profit'
				get :search_results, :params => {:search_text => search_text, :organizationSearchField => "Details", :userSearchField => "None", :ticketSearchField => "None"}
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = 'Non profit'
				get :search_results, :params => {:search_text => search_text, :organizationSearchField => "Details", :userSearchField => "None", :ticketSearchField => "None"}
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = 'Non profit'
				get :search_results, :params => {:search_text => search_text, :organizationSearchField => "Details", :userSearchField => "None", :ticketSearchField => "None"}
				expect(response.body).to match /#{search_text}/
			end

		end

		describe " Request should return search results for a ticket ID with white spaces to the left and right - 
					Validating White space trimming " do

			it " should have the response code 200 " do
				search_text = '436bf9b0-1147-4c0a-8439-6f79833bff5b'
				get :search_results, :params => {:search_text => "         "+search_text+"       ", :ticketSearchField => "_ID", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = '436bf9b0-1147-4c0a-8439-6f79833bff5b'
				get :search_results, :params => {:search_text => "         "+search_text+"       ", :ticketSearchField => "_ID", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = '436bf9b0-1147-4c0a-8439-6f79833bff5b'
				get :search_results, :params => {:search_text => "         "+search_text+"       ", :ticketSearchField => "_ID", :userSearchField => "None", :organizationSearchField => "None" }
				expect(response.body).to match /#{search_text}/
			end

		end

		describe " Request should return user with an unavailable name value 'harrypotterharrypotterharrypotter' -
					Validating nil search results " do

			it " should have the response code 200 " do
				search_text = 'harrypotterharrypotterharrypotter'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None"}
				expect(response.status).to eq 200
			end

			it " should successfully render expected partial " do
				search_text = 'harrypotterharrypotterharrypotter'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None"}
				expect(response).to render_template(:partial => '_search_results')
			end

			it " should validate response body content " do
				search_text = 'harrypotterharrypotterharrypotter'
				get :search_results, :params => {:search_text => search_text, :userSearchField => "Name", :ticketSearchField => "None", :organizationSearchField => "None"}
				expect(response.body).to match /Sorry, no results found./
			end

		end

		describe " Request should handle errors and print them on the console when a search parameter is not passed " do

			it " should validate response body content " do
				get :search_results, :params => {:search_text => "", :userSearchField => "Name", :ticketSearchField => "None"}
				expect(response.body).to match /redirected/
			end

			it " should validate response code " do
				get :search_results, :params => {:search_text => "", :userSearchField => "Name", :ticketSearchField => "None"}
				expect(response.status).to eq 302
			end

		end

	end
end
