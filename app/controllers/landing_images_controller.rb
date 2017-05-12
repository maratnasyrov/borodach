class LandingImagesController < ApplicationController
  expose(:landing_images) { LandingImage.all }
  expose(:landing_image)

  def create
    landing_image = LandingImage.create(landing_images_params)
    success = landing_image.save

    redirect_to landing_images_path if success
  end

  def destroy
    success = landing_image.destroy

    redirect_to landing_images_path if success
  end

  private

  def landing_images_params
    params.require(:landing_image).permit(:image)
  end
end
