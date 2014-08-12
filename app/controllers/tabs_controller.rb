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
    if tab_exists
      @tab = @project.tabs.create(tab_params)
      
      redirect_to @project
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

  def tab_exists
    File.exists?(Dir.home + '/project_view/' + @project.name + '/' + tab_params[:path].to_s)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_tab
    @tab = Tab.find params[:id_tab]
  end

  def tab_params
    params.require(:tab).permit(:path)
  end
end











