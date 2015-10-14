class Record < ActiveRecord::Base
  has_many :record_involvements
  has_many :users, through: :record_involvements

  belongs_to :payer, class_name: User.name
  belongs_to :group
end
