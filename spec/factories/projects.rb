FactoryGirl.define do
  factory :project do
    name 'test_name'
    url 'https://github.com/test_name'
  end
  
  factory :invalid_project, parent: :project do
    name ''
    url ''
  end
end