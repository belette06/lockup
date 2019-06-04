# frozen_string_literal: true

# == Schema Information
#
# Table name: homes
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  proprietor_id :bigint(8)        not null
#
# Indexes
#
#  index_homes_on_proprietor_id  (proprietor_id)
#
# Foreign Keys
#
#  fk_rails_...  (proprietor_id => proprietors.id)
#

class Home < ApplicationRecord
  belongs_to :proprietor

  has_many :appointments, dependent: :destroy
  has_many :tenants, through: :appointments
  accepts_nested_attributes_for :appointments
  accepts_nested_attributes_for :tenants



end
