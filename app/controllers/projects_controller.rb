class ProjectsController < ApplicationController

  before_action :set_project, only:[:destroy, :show]
  @@PATH = "#{Dir.home}/project_view"

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.name = project_name
    if @project.save
      clone_repository
      redirect_to @project
    else
      render :new
    end
  end

  def show
    if @project.cloned?
      render 'projects/show'
    elsif !@project.cloned? and @project.can_be_cloned
      render 'projects/show-wait'
    else
      render 'projects/show-error'
    end
  end

  def destroy
    @project.destroy
    system("rm -rf #{@@PATH}/#{project_name}")
    redirect_to projects_url
  end

  private

  def update_project
    @project.save
  end

  def clone_repository
    CloneWorker.perform_async "#{@project[:url]}", "#{@project.name}", @@PATH, @project.id.to_s
    ValidationWorker.perform_async @project.id.to_s,  @@PATH
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







