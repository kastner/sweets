ActionController::Routing::Routes.draw do |map|
  map.root :controller => "projects", :action => "home"
  map.resource :project, :has_many => :filters
  map.resources :sessions, :only => [:create, :destroy]
end
