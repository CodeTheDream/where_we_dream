class UserMailer < ApplicationMailer
  default from: 'Where We DREAM <info@wherewedream.org>'

  def activate(user)
    @user = user
    foo = user.id
    bar = user.password_digest.clean
    # domain  = root_url
    domain  = Rails.env.production? ? "http://wherewedream.org/" : "http://localhost:3000/"
    @url = domain + "/activate?foo=#{foo}&bar=#{bar}"
    mail(to: @user.email, subject: 'Activate your account')
  end
end
