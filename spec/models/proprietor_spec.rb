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
  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false)}
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(default: "", null: false) }
  end



  it 'validates testes' do
   let(:proprietor) {create(:proprietor)}

    it 'ensures presence name' do
      should validate_presence_of(:name)
    end
  end

  describe ' Factories' do
    context ' with valid attributes' do
      let(:proprietor) {build(:proprietor)}

      it 'is valid with attributes' do
        expect(:proprietor).to be_valid
      end
    end
  end
end
