Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "search/index"

  get  '/search_results', to: 'search#search_results'

  root "search#index"
  
end
