class RegistrationsController < Devise::RegistrationsController

 private

 def sign_up_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :slack_id)
 end

 def account_update_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :slack_id)
 end
end