class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from CanCan::AccessDenied do |exception|
    render json: { detail: exception }, status: :unauthorized
  end
end
