# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invites
class InvitesPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/invite_mailer/new_user_invite
  def new_user_invite
    InviteMailer.new_user_invite
  end
end
