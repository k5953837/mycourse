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
FactoryBot.define do
  factory :course do
    subject { Faker::Name.name }
    price { Faker::Number.decimal }
    currency { Course.currencies.keys.sample }
    category { Course.categories.keys.sample }
    status { 'online' }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    duration { Faker::Number.between(from: 1, to: 30) }
  end
end
