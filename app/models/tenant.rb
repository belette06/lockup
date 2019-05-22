# frozen_string_literal: true

# == Schema Information
#
# Table name: tenants
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tenant < ApplicationRecord
  #  attr_accessible :name

  has_many :appointments, dependent: :destroy
  has_many :homes, through: :appointments

  accepts_nested_attributes_for :homes
  accepts_nested_attributes_for :appointments

  ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
end
