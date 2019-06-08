# frozen_string_literal: true
# == Schema Information
#
# Table name: appointments
#
#  id               :bigint(8)        not null, primary key
#  ends_at          :datetime
#  kind             :string           not null
#  starts_at        :datetime
#  weekly_recurring :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
