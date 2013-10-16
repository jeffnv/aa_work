class UserMailer < ActionMailer::Base
  default from: "admin@friendcircle.love"

  def reset_email(user)
    @user =  user
    @url = "http://localhost:3000/users/reset?reset_token=#{@user.reset_token}"
    mail(to: user.email, subject: 'Good job forgetting your password.')
  end
end
