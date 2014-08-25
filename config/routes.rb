
Rails.application.routes.draw do

  #------------- project --------------
  get 'projects/new', to: 'projects#new', as: 'new_project'
  get 'projects', to: 'projects#index', as: 'projects'
  get ':name', to: 'projects#show', as: 'project'
  post 'projects', to: 'projects#create'
  delete ':name', to: 'projects#destroy'

  #-------------- tab ----------------

  scope ":project_name" do
    get 'tabs', to: 'tabs#index', as: 'tabs'
    post 'tabs', to: 'tabs#create', as: 'new_tab_to_project'
    get 'tabs/new', to: 'tabs#new', as: 'new_tab'
    get ':tab_name', to: 'tabs#show', as: 'tab'
    delete 'tabs/:tab_name', to: 'tabs#destroy', as: 'destroy_tab'
  end 
end
