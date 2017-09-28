class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  after_action :verify_authorized, except: [:index, :home], unless: :devise_controller?

  private

    def not_authorized
      redirect_to root_path, alert: "You are not allowed to do that."
    end
end
