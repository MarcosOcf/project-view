class CloneWorker
  include Sidekiq::Worker

  def perform url, name, path, project_id
    project = Project.find project_id
    
    begin
      Git.clone(url, name, path: path, depth: 1)
    rescue => e
      Rails.logger.error e.message
      invalidate project
    end
  end
  
  def invalidate project
    project.can_be_cloned = false
    project.save(validate: false)
  end
end

