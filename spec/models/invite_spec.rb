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

require 'rails_helper'

RSpec.describe Invite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
