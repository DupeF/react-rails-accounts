class PersonalBalance < ActiveRecord::Base
  has_many :records, class_name: PersonalRecord.name
  belongs_to :user

end
