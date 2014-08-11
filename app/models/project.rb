class Project
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :url, type: String
  field :name, type: String
  field :cloned, type: Boolean, default: false
  field :can_be_cloned, type: Boolean, default: true
  validates_presence_of :name, :url
end
