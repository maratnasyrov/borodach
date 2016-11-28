class MasterDecorator < ApplicationDecorator
  delegate :id, :name, :last_name

  def master_info
    "#{object.name} #{object.last_name}"
  end

end
