Rails.application.routes.draw do

  #------------- project --------------
  get 'projects/new', to: 'projects#new', as: 'new_project'
  get 'projects/index', to: 'projects#index', as: 'projects'
  get 'projects/:id', to: 'projects#show', as: 'project'
  post 'projects/index', to: 'projects#create'
  delete 'projects/:id', to: 'projects#destroy'

  #-------------- tab ----------------

  scope "projects/:project_id" do
    get 'tabs', to: 'tabs#index', as: 'tabs'
    post 'tabs', to: 'tabs#create', as: 'new_tab_to_project'
    get 'tabs/new', to: 'tabs#new', as: 'new_tab'
    get 'tabs/:id', to: 'tabs#show', as: 'tab'
    delete 'tabs/:id', to: 'tabs#destroy', as: 'destroy_tab'
  end

  #------------- math ----------------

  #get ':name', to: 'projects#show'
  #match ':projects/:project.name/tabs.path', to: 'tabs#show', as: 'tab'
end
