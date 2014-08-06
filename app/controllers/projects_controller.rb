class ProjectsController < ApplicationController

  before_action :set_project, only:[:destroy]
  @@PATH = "#{Dir.home}/project_view"

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      clone_repository
      redirect_to :projects
    else
      render :new
    end
  end

  def show
    # if @project.cloned?
    #   # Página!
    # elsif !@project.cloned? and @project.created_at < (@project.created_at + 15.minutes)
    #   # Aguenta ai um pouco
    # else
    #   # deu pau, tenta clonar de novo
    # end
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
    CloneWorker.perform_async "#{@project[:url]}", "#{project_name}", @@PATH, @project.id.to_s
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







