class LandingImage < ActiveRecord::Base
  scope :set_image, -> (num) { where(id: num) }

  has_attached_file :image, styles: { medium: "200x200", thumb: "100x100>" }, default_url: "no_image2.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
