# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  category   :integer          default("programming")
#  expired_at :datetime
#  snapshot   :jsonb            not null
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_orders_on_category  (category)
#  index_orders_on_subject   (subject)
#  index_orders_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
    it { should belong_to(:user) }
  end

  # Callbacks specs
  context 'Callbacks specs' do
  end

  # Validations specs
  context 'Validations specs' do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:expired_at) }
    it { should validate_presence_of(:snapshot) }
    it { should validate_presence_of(:subject) }
    it { should define_enum_for(:category).with_values(Course.categories.keys) }
    it { is_expected.to callback(:set_expired_at).before(:create) }

    describe 'before_create' do
      let(:order) { build(:order) }

      it '#set_expired_at' do
        order.send(:set_expired_at)
        expect(order.expired_at.to_i).to eq((Time.now + order.snapshot['duration'].days).to_i)
      end
    end
  end

  # Scopes specs
  context 'Scopes specs' do
    describe '.available' do
      it 'list available orders' do
        # Create advertise
        order = create :order
        order.update(expired_at: Time.now - 1.day)
        # Check mehtod
        expect(Order.available.size).to eq(0)
      end
    end
  end

  # Class methods specs
  context 'Class method specs' do
  end

  # Instance methods specs
  context 'Instance method specs' do
  end
end
