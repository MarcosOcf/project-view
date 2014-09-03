require "rails_helper"

describe Project do

  before do 
    @attr = {
      url: 'https://github.com/some_project',
      name: 'some_project'
    }
  end

  after(:all) do
    @attr.destroy
  end

  it "should create a new instance given a valid attribute" do
    Project.create!(@attr)
  end

  it "should require url" do
    no_url_project = Project.new(@attr.merge(:url => nil))
    expect(no_url_project).not_to be_valid
  end

  it "should require name" do
    no_name_project = Project.new(@attr.merge(:name => nil))
    expect(no_name_project).not_to be_valid
  end
end