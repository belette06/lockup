# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitesMailer, type: :invites_mailer do
  def welcome
    Notifier.welcome(User.first)
  end
end
