class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  def show_settings
    render "settings"
  end
end
