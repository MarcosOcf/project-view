class Project
  include Mongoid::Document
  include Mongoid::Slug

  field :url, type: String
  field :name, type: String
  slug :name, localize: true
  field :cloned, type: Boolean, default: false
  field :can_be_cloned, type: Boolean, default: true
  
  validates_presence_of :name, :url, :message => "Algum campo está vazio"

  has_many :tabs

  before_destroy :delete_directory

  private
  def delete_directory
    system("rm -rf #{@@PATH}/#{project_name}")
  end

  def to_param
    name
  end
end
