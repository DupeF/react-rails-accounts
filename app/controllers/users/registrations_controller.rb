class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      resource.create_personal_balance
    end
  end

end
