require 'rails_helper'

describe Tab do
  before do 
    @attr = {
      path: 'some/path/to/project',
      html: '',
      name: 'some_project'
    }
  end

  after(:all) do
    @attr.destroy
  end

  it "should create a new instance given a valid attribute" do
    Tab.create!(@attr)
  end
end