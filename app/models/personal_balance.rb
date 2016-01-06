class PersonalBalance < ActiveRecord::Base
  has_many :records, class_name: PersonalRecord.name
  belongs_to :user

  validates_presence_of :name, :user

end
