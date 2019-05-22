# frozen_string_literal: true

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

class Appointment < ApplicationRecord
  belongs_to :home
  belongs_to :tenant

  accepts_nested_attributes_for :tenant

  ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)

  # def tenant_name
  # @tenant.name = tenant_name
  # end

  # def create_tenant
  # Tenant.create(params[:tenant])
  # end
end
