# frozen_string_literal: true

# == Schema Information
#
# Table name: relations
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  homes_id   :bigint(8)        not null
#  tenant_id  :bigint(8)        not null
#
# Indexes
#
#  index_relations_on_homes_id   (homes_id)
#  index_relations_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (homes_id => homes.id)
#  fk_rails_...  (tenant_id => tenants.id)
#

FactoryBot.define do
  factory :relation do
    appointment { nil }
    home { nil }
  end
end
