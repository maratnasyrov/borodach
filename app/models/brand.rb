class Brand < ActiveRecord::Base
  has_many :purchases
  has_many :shelves
  has_many :categories

  belongs_to :providers

  scope :sort_by_name, -> { order('name ASC')  }

  has_attached_file :image, styles: { medium: "200x200", thumb: "100x100>" }, default_url: "no_image2.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
