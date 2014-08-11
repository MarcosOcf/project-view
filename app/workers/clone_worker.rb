class CloneWorker
  include Sidekiq::Worker

  def perform url, name, path, project_id
    project = Project.find project_id
    begin
      Git.clone(url, name, path: path)
    rescue
      invalidate_clone
    end
  end

  def invalidate_clone
    project.can_be_cloned = false
    project.save(validate: false)
  end
end

