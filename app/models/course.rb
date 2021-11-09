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
class Course < ApplicationRecord
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  enum category: { programming: 0, project_management: 1 }
  enum currency: { ntd: 0, usd: 1 }
  enum status: { offline: 0, online: 1 }

  # Association macros

  # Association through macros

  # Validation macros
  validates :category, :currency, :status, :subject, :url, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 30 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, inclusion: { in: categories.keys }
  validates :currency, inclusion: { in: currencies.keys }
  validates :status, inclusion: { in: statuses.keys }
  validates :url, url: true

  # Callbacks

  # Other
end
