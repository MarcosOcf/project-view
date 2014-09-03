class PullWorker
  include Sidekiq::Worker

  def perform path, project_s = all_projects
    @path = path
    @project_s = project_s
    if project_s.class == Array
      project_s.each do |project|
        pull project_s
      end
    else
      pull projects
    end
  end

  def pull project
    git = Git.open(@path + '/' + project.name)
    git.pull
  end

  def all_projects
    projects = Dir.entries(@path)
    non_projects = [".","..",".DS_Store"] 
    non_projects.each { |dir| projects.delete(dir) }
    projects
  end
end