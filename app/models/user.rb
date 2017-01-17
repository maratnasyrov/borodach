class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true
end
