class Tab
  include Mongoid::Document

  field :path, type: String
  field :html, type: String
  belongs_to :project
  
  validates_presence_of :path, :message => "Preencher o campo"

end
