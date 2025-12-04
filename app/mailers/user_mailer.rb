# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "Bharatgrowbusiness"
  p "================UserMailer"
  def status_updated(user)
    p "=---------- user welcome"
    p user
    @user = user
    mail(to: @user.email, subject: "Your account status has been updated")
  end

  def send_email_otp(user, otp)
    p "==============user"
    @user = user
    p "==============user"
    p @user.email
    @otp = otp
    mail(to: @user.email, subject: "Your Login OTP Code")
  end

  def forgot_email
    p "==============="
    @user = params[:user]
    @otp  = params[:otp]
    p "===========ope forgot_email"
    p @otp
    mail(to: @user.email, subject: "Your OTP code")
  end

  def reset_password_otp
    @user = params[:user]
    @otp = params[:otp]

    mail(
      to: @user.email,
      subject: "Your Password Reset OTP Code"
    )
  end

  def transcation_email_otp(user:, otp:)
    @user = user
    @otp = otp

    mail(
      to: @user.email,
      subject: "Your OTP for Transaction PIN Reset"
    )
  end

  def status_updated(user)
    p "=---------- user welcome"
    p user
    @user = user
    mail(to: @user.email, subject: "Your account status has been updated")
  end

end
