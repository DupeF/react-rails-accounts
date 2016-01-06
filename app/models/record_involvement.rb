class RecordInvolvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :record

  validates_presence_of :user, :record
end
