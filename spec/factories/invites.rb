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

FactoryBot.define do
  factory :invite do
    email { 'MyString' }
    appointment_id { 1 }
    sender_id { '' }
    recipient_id { 1 }
    token { 'MyString' }
  end
end
