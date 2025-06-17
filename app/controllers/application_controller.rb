class ApplicationController < ActionController::API
  respond_to :json
  before_action :authenticate_user!, unless: :devise_controller?
end
