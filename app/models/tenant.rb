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

  has_many :appointments ,dependent: :destroy
  has_many :homes, through: :appointments
end
