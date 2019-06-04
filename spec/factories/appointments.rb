# frozen_string_literal: true
# == Schema Information
#
# Table name: appointments
#
#  id               :bigint(8)        not null, primary key
#  ends_at          :datetime
#  kind             :string
#  starts_at        :datetime
#  weekly_recurring :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  home_id          :bigint(8)        not null
#
# Indexes
#
#  index_appointments_on_home_id  (home_id)
#
# Foreign Keys
#
#  fk_rails_...  (home_id => homes.id)
#

FactoryBot.define do
  factory :appointment do
    home { nil }
    tenant { nil }
  end
end
