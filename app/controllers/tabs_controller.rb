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
        @tab = @project.tabs.create(tab_params)
        create_html
        redirect_to @project
      rescue => e
        Rails.logger.error "tab valido: #{@tab.valid?}"
        Rails.logger.error @tab.errors
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

  def create_html
    @tab.html = File.open(Dir.home + '/project_view/' + @project.name + '/' + @tab.path, 'r').read
    @tab.save
  end


  def tab_exists
    File.exists?(Dir.home + '/project_view/' + @project.name + '/' + tab_params[:path].to_s)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tab
    @tab = Tab.find params[:id]
  end

  def tab_params
    params.require(:tab).permit(:path)
  end
end











