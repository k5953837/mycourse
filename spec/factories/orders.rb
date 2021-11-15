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
FactoryBot.define do
  factory :order do
    expired_at { Time.now + Faker::Number.between(from: 1, to: 30).day }
    subject { Faker::Name.name }
    category { Course.categories.keys.sample }
    snapshot do
      {
        "suject": subject,
        "price": Faker::Number.decimal,
        "currency": Course.currencies.keys.sample,
        "category": category,
        "url": Faker::Internet.url,
        "description": Faker::Lorem.paragraph,
        "duration": Faker::Number.between(from: 1, to: 30)
      }
    end
    user
  end
end
