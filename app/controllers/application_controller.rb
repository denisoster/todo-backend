class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pagination
  before_action :pagination_params

  rescue_from CanCan::AccessDenied do |exception|
    render json: { detail: exception }, status: :unauthorized
  end
end
