class Trip < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates  :user_id,    presence: true
  validates  :title,      presence: true,
                            length: {maximum: 100}
  validates  :images, content_type: { in: %w[image/jpeg image/gif image/png] }

  default_scope -> { order(created_at: :desc) }

  def top_image
    if self.images.attached?
      self.images.first.variant(resize_to_fill: [320, 320])
    else
      "default.jpg"
    end
  end
end
