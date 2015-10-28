class PersonalRecord < ActiveRecord::Base
  include TimeFiltersConcern

  belongs_to :personal_balance
end
