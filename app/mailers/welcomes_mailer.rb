class WelcomesMailer < ApplicationMailer
  def welcomes_send(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Memory Cards!', from: 'memory.card.team.a@gmail.com'
  end
end
