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
#  tenant_id        :bigint(8)        not null
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

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
