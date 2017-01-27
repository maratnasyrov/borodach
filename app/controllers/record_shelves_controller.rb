class RecordShelvesController < ApplicationController
  expose(:record)
  
  expose(:record_shelves)
  expose(:record_shelf, attributes: :record_shelf_params)

  def create
    record_shelf = RecordShelf.create(record_shelf_params)
    success = record_shelf.save
    render_record_shelves if success
  end

  def destroy
    success = record_shelf.destroy

    render_record_shelves if success
  end

  private

  def render_record_shelves
    respond_to do |format|
      format.html
      format.js { render 'record_shelves/_record_shelves' }
    end
  end

  def record_shelf_params
    params.require(:record_shelf).permit(:record_id, :shelf_id, :number).merge(record_id: record.id)
  end
end
