class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: {maximum: 35}
end
