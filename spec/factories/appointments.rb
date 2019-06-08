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

FactoryBot.define do
  factory :appointment do
    home { nil }
    tenant { nil }
  end
end
