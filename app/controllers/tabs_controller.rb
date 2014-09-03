 class TabsController < ApplicationController

  before_action :set_project, only:[:new, :create, :destroy, :show]
  before_action :set_tab, only:[:show, :destroy]

  def index
    @tabs = Tab.all
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new tab_params
    if tab_exists
      begin
        @tab = @project.tabs.create(new_tab_params)
        create_html
        redirect_to @project
      rescue => e
        #enviar erro para a tela
        redirect_to new_tab_path
      end
    else
      redirect_to new_tab_path
    end
  end

  def show
  end

  def destroy
    @tab.destroy
    redirect_to @project
  end

  private

  def new_tab_params
    params = {}
    params['name'] = verify_params
    params['path'] = @tab.path
    params 
  end

  def verify_params
    if @tab.name != ''
      modify @tab.name
    else
      cut @tab.path
    end
  end

  def cut path
    name = /\/?[^\/]*\./.match(path).to_s.delete('/').delete('.')
    @tab.name = modify name
  end

  def modify name
    name.downcase.gsub(' ','_').gsub('ç','c')
  end

  def create_html
    @tab.html = File.open(Dir.home + '/project_view/' + @project.name + '/' + @tab.path, 'r').read
    @tab.save
  end

  def tab_exists
    File.exists?(Dir.home + '/project_view/' + @project.name + '/' + tab_params[:path].to_s)
  end

  def set_project
    @project = Project.find_by name: params[:project_name]
  end

  def set_tab
    @tab = @project.tabs.find_by name: params[:tab_name]
  end

  def tab_params
    params.require(:tab).permit(:name,:path)
  end
end


