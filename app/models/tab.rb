class Tab
  include Mongoid::Document
  field :name, type: String
  field :path, type: String
  field :html, type: String
  belongs_to :project
  
  validates_presence_of :path, :message => "Preencher o campo"

end
