class SendSignupEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.signup_email(user).deliver_now
  end
end
