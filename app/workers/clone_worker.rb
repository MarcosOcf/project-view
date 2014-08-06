class CloneWorker
  include Sidekiq::Worker

  def perform url, name, path, project_id
    project = Project.find project_id
    begin
      Git.clone(url, name, path: path)
      if Dir.exist?(path+name)
        project.cloned = true
        project.save(validate: false)
      end
    rescue
      false
    end
  end
end

