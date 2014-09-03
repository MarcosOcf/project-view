# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tab do
    path "some/path/example"
    name "tab_name"
    html "some_html_example"
  end
end
