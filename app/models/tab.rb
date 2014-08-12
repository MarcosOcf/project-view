class Tab
  include Mongoid::Document

  field :path, type: String
  belongs_to :project

  validates_presence_of :path
end
