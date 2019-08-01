# frozen_string_literal: true

# == Schema Information
#
# Table name: proprietors
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_proprietors_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Proprietor < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :homes

  validates :name, presence: true, uniqueness: true
end
