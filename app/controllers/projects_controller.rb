class ProjectsController < ApplicationController
  
  before_action :set_project, only:[:destroy]
  PATH = "#{Dir.home}/project_view"

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.cloned = false
    if clone? and @project.save
      redirect_to :projects
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @project.destroy
    system("rm -rf #{PATH}/#{project_name}")
    redirect_to projects_url
  end

  private

  def clone?
    begin
      Git.clone("#{@project.url}", "#{project_name}", :path => "#{Dir.home}/project_view")
      true
    rescue
      false 
    end
  end

  def project_name
    @project.name.gsub(" ","_")
  end

  def set_project 
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name,:url)
  end
end


