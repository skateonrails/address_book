module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      error_hash = { error: { message: exception.message } }
      render json: error_hash, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      error_hash = { error: { message: exception.message } }
      render json: error_hash, status: :unprocessable_entity
    end
  end
end
