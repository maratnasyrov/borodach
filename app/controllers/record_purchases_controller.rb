class RecordPurchasesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:destroy, :create]

  expose(:record)
  
  expose(:record_purchases)
  expose(:record_purchase, attributes: :record_purchase_params)
  expose(:brands) { Brand.all }

  def create
    record_purchase = RecordPurchase.create(record_purchase_params)
    success = record_purchase.save
    render_record_purchase if success
  end

  def destroy
    success = record_purchase.destroy

    render_record_purchase if success
  end

  private

  def render_record_purchase
    respond_to do |format|
      format.html
      format.js { render 'record_purchases/_record_purchases' }
    end
  end

  def record_purchase_params
    params.require(:record_purchase).permit(:purchase_id, :record_id).merge(record_id: record.id)
  end
end
