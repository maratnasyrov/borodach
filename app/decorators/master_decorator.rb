class MasterDecorator < ApplicationDecorator
  delegate :id, :name, :last_name

  def master_info
    "#{object.name} #{object.last_name}"
  end

  def show_shelf_history(day_id)
    history_hash = {}

    object.shelf_histories.find_day(day_id).each do |shelf_history|
      shelf_name = Shelf.find_by(id: shelf_history.shelf_id).name
      number_changes = shelf_history.number_changes

      add_hash = { "#{shelf_name}" => number_changes }
      history_hash.merge!(add_hash) { |key, oldval, newval| newval + oldval }
    end

    return history_hash
  end

  def service_info
    info = object.about_master.split(";")

    return info
  end

  def services_in_about_master
    description = [service_info.first]
    about_services =  service_info - description
    hash_services = {}
    about_services.each do |about_service|
      info = about_service.split("-")
      info.first.slice! "\r\n"

      key = info.first
      value = info.second

      hash_services[key] = value
    end

    return description.first, hash_services
  end
end
