class ProvidersController < ApplicationController
  expose(:providers) { Provider.all }
  expose(:provider, attributes: :providers_params)

  expose(:category) { Category.new() }
  expose(:brand) { Brand.new() }

  def create
    success = Provider.create(providers_params)
    redirect_to providers_path if success
  end

  def update
    success = provider.update(providers_params)
    redirect_to providers_path if success
  end
  
  def destroy
    brands_empty = provider.brands.empty?

    success = provider.destroy if brands_empty

    if success
      redirect_to providers_path
    else
      redirect_to providers_path, notice: "Удаление невозможно, так как есть бренды и категории данного поставщика!"
    end
  end

  private

  def providers_params
    params.require(:provider).permit(:name, :email, :phone_number, :contact_name)
  end
end