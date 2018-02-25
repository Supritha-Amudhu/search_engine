Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "search/index"
  # get "search/search_results"

  get  '/search_results', to: 'search#search_results'

  # get "search/search_results"

  # resource :search do
  # 	get "index"
  # 	get "search_results"
  # end

  # map.root :controller => 'pages', :action => 'home'
  root "search#index"
end
