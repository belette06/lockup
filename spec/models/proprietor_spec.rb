# frozen_string_literal: true

# == Schema Information
#
# Table name: proprietors
#
#  id         :bigint(8)        not null, primary key
#  name       :string
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

require 'rails_helper'

RSpec.describe Proprietor, type: :model do
  it 'create home' do
    Proprietor.create(name: "teste_name")
  end
end
