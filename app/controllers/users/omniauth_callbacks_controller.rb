class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = ::User.from_omniauth(oauth_response)
      if @user.persisted?
        sign_in sign_in @user, :event => :authentication
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: "Google")
      else
        session['devise.google_data'] = oauth_response.except(:extra)
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
end
