# frozen_string_literal: true

# == Schema Information
#
# Table name: invites
#
#  id             :bigint(8)        not null, primary key
#  email          :string
#  token          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  appointment_id :integer
#  recipient_id   :integer
#  sender_id      :integer
#

class Invite < ApplicationRecord
  before_create :generate_token
  before_save :check_user_existence

  belongs_to :appointment
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', optional: true

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.appointment_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    self.recipient_id = recipient.id if recipient
  end
end
