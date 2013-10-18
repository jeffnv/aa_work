# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyString"
    parent_comment_id 1
    link_id 1
    author_id 1
  end
end