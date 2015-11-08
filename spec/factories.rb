FactoryGirl.define do
  factory :user do
    email 'john.doe@test.com'
    password 'password'
  end

  factory :personal_balance, aliases: [:balance] do
    name 'balance'
  end
end