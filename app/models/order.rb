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
class Order < ApplicationRecord
  # Scope macros
  scope :available, -> { where('expired_at > ?', Time.now) }

  # Concerns macros

  # Constants

  # Attributes related macros
  enum category: Course::categories

  # Association macros
  belongs_to :user

  # Association through macros

  # Validation macros
  validates :category, :expired_at, :snapshot, :subject, presence: true
  validates :category, inclusion: { in: Course::categories.keys }

  # Callbacks
  before_create :set_expired_at

  # Other

  private

  def set_expired_at
    self.expired_at = Time.now + snapshot['duration'].days
  end
end
