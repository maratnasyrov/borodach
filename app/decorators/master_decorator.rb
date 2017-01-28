class MasterDecorator < ApplicationDecorator
  delegate :id, :name, :last_name

  def master_info
    "#{object.name} #{object.last_name}"
  end

  def show_shelf_history
    history_hash = {}

    object.shelf_histories.all.each do |shelf_history|
      shelf_name = Shelf.find_by(id: shelf_history.shelf_id).name
      number_changes = shelf_history.number_changes

      add_hash = { "#{shelf_name}" => number_changes }
      history_hash.merge!(add_hash) { |key, oldval, newval| newval + oldval }
    end

    return history_hash
  end
end
