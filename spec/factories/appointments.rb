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
#  home_id          :bigint(8)
#  tenant_id        :bigint(8)
#
# Indexes
#
#  index_appointments_on_home_id    (home_id)
#  index_appointments_on_tenant_id  (tenant_id)
#

FactoryBot.define do
  factory :appointment do
    home { create(:home) }
    tenant { belong_to(:tenant) }
  end
end
