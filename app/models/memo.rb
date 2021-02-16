class Memo < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates  :user_id, presence: true
  validates  :content, length: { maximum: 200 }
  validates  :content_or_address, presence: true

  private

  def content_or_address
    content.presence || address.presence
  end
end
