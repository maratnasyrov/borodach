class Master < ActiveRecord::Base
  has_many :work_days
  has_many :shelf_histories
  has_many :clients
  has_many :client_histories
  has_many :services
  has_many :working_shifts
  has_many :month_salaries

  belongs_to :salons
  
  scope :sort_by_id, -> { order('id ASC') }
  scope :sort_by_name, -> { order('name ASC') }

  has_attached_file :avatar, styles: { medium: "200x200", thumb: "100x100>" }, default_url: "no_image2.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end