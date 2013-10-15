class UserMailer < ActionMailer::Base
  default from: "skipper@jtunes.dope"
  def welcome_email(user)
     @user = user
     @url  = "http://localhost:3000/users/#{user.activation_token}"
     mail(to: user.email, subject: 'Welcome to My Awesome Site')
   end
end
