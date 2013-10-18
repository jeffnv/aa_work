# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_vote do
    link_id 1
    sequence(:voter_id) {|n| n}
    sequence(:vote) { |n| n.even? ? 1 : -1 }
  end
end
