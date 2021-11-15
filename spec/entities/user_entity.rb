require 'rails_helper'

describe ApiV1::Entities::User do
  describe 'fields' do
    let!(:user) { create :user }
    specify 'presents the first available token' do
      json = ApiV1::Entities::User.new(user).as_json
      expect(json[:email]).to eq(user.email)
      expect(json[:token]).to be_present
      expect(json[:updated_at]).to eq(user.updated_at.iso8601)
    end
  end
end
