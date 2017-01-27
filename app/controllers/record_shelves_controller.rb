class RecordShelvesController < ApplicationController
  expose(:record)
  expose(:work_day) { WorkDay.find_by id: record.work_day_id }
  expose(:day) { Day.find_by id: work_day.day_id }
  
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
    params.require(:record_shelf).permit(:record_id, :shelf_id, :number, :day_id).merge(record_id: record.id, day_id: day.id)
  end
end
