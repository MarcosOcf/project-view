class Project
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :url, type: String
  field :name, type: String
  field :cloned, type: Boolean, default: false
  validates_presence_of :name, :url
end
