class Memo < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates  :user_id,    presence: true
  validates  :content,    presence: true

end
