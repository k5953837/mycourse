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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  enum role: { general: 0, admin: 1 }

  # Association macros
  has_many :orders, dependent: :destroy

  # Association through macros

  # Validation macros

  # Callbacks
  before_create :generate_jti

  # Other

  private

  def generate_jti
    self.jti = SecureRandom.hex(16)
    loop do
      break unless User.exists?(jti: jti)

      self.jti ||= SecureRandom.hex(16)
    end
  end
end
