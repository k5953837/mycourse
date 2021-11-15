require 'rails_helper'

describe ApiV1::Entities::Order do
  describe 'fields' do
    let!(:order) { create :order }
    specify 'presents the first available token' do
      json = ApiV1::Entities::Order.new(order).as_json
      expect(json[:category]).to eq(order.category)
      expect(json[:expired_at]).to eq(order.expired_at.iso8601)
      expect(json[:snapshot]).to eq(order.snapshot)
      expect(json[:subject]).to eq(order.subject)
      expect(json[:updated_at]).to eq(order.updated_at.iso8601)
    end
  end
end
