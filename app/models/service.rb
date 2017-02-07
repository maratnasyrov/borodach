class Service < ActiveRecord::Base
  has_many :record_services

  scope :beard, -> { where(name: "Оформление бороды") }
  scope :hair, -> { where(name: "Стрижка") }
  scope :hair_beard, -> { where(name: "Стрижка + Борода") }
  scope :hair_correction, -> { where(name: "Коррекция стрижки") }
end
