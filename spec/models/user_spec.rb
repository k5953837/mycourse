# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("general")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
  end

  # Callbacks specs
  context 'Callbacks specs' do
  end

  # Validations specs
  context 'Validations specs' do
    it { is_expected.to callback(:generate_jti).before(:create) }

    describe 'before_create' do
      let(:user) { create(:user, jti: nil) }

      it '#generate_jti' do
        # Check user jti exist?
        expect(user.jti).to be_present
      end
    end
  end

  # Scopes specs
  context 'Scopes specs' do
  end

  # Class methods specs
  context 'Class method specs' do
  end

  # Instance methods specs
  context 'Instance method specs' do
  end
end
