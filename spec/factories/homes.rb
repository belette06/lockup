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

FactoryBot.define do
  factory :home do
    name { "MyString" }
    proprietor { nil }
  end
end