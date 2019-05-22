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

FactoryBot.define do
  factory :tenant do
    name { "MyString" }
  end
end
