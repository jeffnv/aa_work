# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title "MyString"
    url "https://www.google.com"
    body "I love Reddit"
    submitter_id 1
  end
end
