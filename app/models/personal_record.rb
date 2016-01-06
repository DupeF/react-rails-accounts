class PersonalRecord < ActiveRecord::Base
  belongs_to :personal_balance

  validates_presence_of :title, :amount, :date, :personal_balance
end
