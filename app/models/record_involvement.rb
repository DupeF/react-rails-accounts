class RecordInvolvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :record
end
