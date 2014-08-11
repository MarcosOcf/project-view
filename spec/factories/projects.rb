FactoryGirl.define do
  factory :project do |proj|
    proj.name 'test_name'
    proj.url 'https://github.com/test_name'
  end
  factory :invalid_project, parent: :project do
    name ''
    url ''
  end
end