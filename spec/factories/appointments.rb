# == Schema Information
#
# Table name: appointments
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  home_id    :bigint(8)        not null
#  tenant_id  :bigint(8)        not null
#
# Indexes
#
#  index_appointments_on_home_id    (home_id)
#  index_appointments_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (home_id => homes.id)
#  fk_rails_...  (tenant_id => tenants.id)
#

FactoryBot.define do
  factory :appointment do
    home { nil }
    tenant { nil }
  end
end
