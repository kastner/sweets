ActionController::Routing::Routes.draw do |map|
  map.resource :project, :has_many => :filters
end
