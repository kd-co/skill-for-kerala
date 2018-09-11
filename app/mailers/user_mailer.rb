class UserMailer < ApplicationMailer
  def send_approval(user)
    @user = user
    mail(
      to: @user.email,
      from: from,
      subject: 'Account activated'
    )
  end

  def send_contact_request(user, client)
    @employee = user
    @client = client
    mail(
      to: @employee.email,
      cc: client.email,
      from: from,
      subject: 'Account activated'
    )
  end
end
