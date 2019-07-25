# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitations_at         :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sent_invites           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Associations' do
    let(:user) { build(:user) }
    it { expect(user).to have_one(:proprietor).dependent(:destroy) }
    it { expect(user).to have_one(:tenant).dependent(:destroy) }
  end

  describe 'Validation' do
     context 'validation tests' do
      let(:user) { create(:user) }

      it 'ensures presence email value' do
        should validate_presence_of(:email)
      end

      it 'ensures password length of 6 char' do
        should validate_length_of(:password).is_at_least(6)
      end
    end
  end
end
describe 'Factories' do
  context 'with valid attributes' do
    let!(:user) { build(:user) }

    it { expect(user.errors).to be_empty }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
  end
end
context 'with unvalid email' do
  let(:user) { build(:user, email: nil) }

  it 'is not valid without email' do
    expect(user).not_to be_valid
  end
end
