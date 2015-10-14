class User < ActiveRecord::Base
  include Gravtastic

  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_gravatar

  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_many :payed_records, class_name: Record.name, inverse_of: :payer, foreign_key: :payer_id
end
