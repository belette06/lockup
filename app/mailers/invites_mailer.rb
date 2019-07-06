class InvitesMailer < ApplicationMailer
  default from: 'teste@example.com'

  def new_user_invite(invite, token)

    @token = token
    @invite  = invite

   mail(to: @invite.email, subject: "Invitation a rejoindre un rendez vous ")
  end
end
