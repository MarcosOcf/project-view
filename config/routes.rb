Rails.application.routes.draw do

  #------------- project --------------
  get 'projects/index', to: 'projects#index', as: 'projects'
  get 'projects/new', to: 'projects#new', as: 'new_project'
  get 'projects/:id', to: 'projects#show', as: 'project'
  post 'projects/index', to: 'projects#create'
  delete 'projects/:id', to: 'projects#destroy'

end
