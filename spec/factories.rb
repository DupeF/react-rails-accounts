FactoryGirl.define do
  factory :user do
    email 'john.doe@test.com'
    password 'password'
  end

  factory :personal_balance, aliases: [:balance] do
    name 'balance'
  end

  factory :group do
    name 'group'
  end

  factory :record do
    title 'title'
    amount 10
    date Date.today
  end

  factory :personal_record do
    title 'title'
    amount 10
    date Date.today
  end
end
