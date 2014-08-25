class ValidationWorker
  include Sidekiq::Worker

  def perform project_id, path
    @project = Project.find project_id
    sleep_time = 0
    
    while @project.can_be_cloned
     
      if folder_exists path, @project.name
        authenticate
        break

      else
        sleep_time += 1
        sleep 1
        if sleep_time >= 10
          invalidate_clone
          break
        end
      end

    end
  end

  def invalidate_clone
    @project.can_be_cloned = false
    save
  end

  def folder_exists path, name
    Dir.exists?(path + '/' + name)
  end

  def authenticate
    @project.cloned = true
    save
  end

  def save
    @project.save(validate: false)
  end
end


