module ApiV1
  class Login < Grape::API
    desc 'End-points for the Login'
    namespace :login do
      desc 'Login via email and password'
      params do
        requires :email, type: String, desc: 'email'
        requires :password, type: String, desc: 'password'
      end
      post do
        user = User.find_by_email params[:email]
        if user.present? && user.valid_password?(params[:password])
          status 200
          present user, with: ApiV1::Entities::User
        else
          error_msg = 'Bad Authentication Parameters'
          error!({ 'error_msg' => error_msg }, 401)
        end
      end
    end
  end
end
