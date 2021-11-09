# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  category    :integer          default("programming")
#  currency    :integer          default("ntd")
#  description :text
#  duration    :integer
#  price       :float
#  status      :integer          default("online")
#  subject     :string
#  url         :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Course, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
  end

  # Callbacks specs
  context 'Callbacks specs' do
  end

  # Validations specs
  context 'Validations specs' do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:url) }
    it { should validate_numericality_of(:duration).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(30) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should define_enum_for(:category).with_values(Course.categories.keys) }
    it { should define_enum_for(:currency).with_values(Course.currencies.keys) }
    it { should define_enum_for(:status).with_values(Course.statuses.keys) }
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
