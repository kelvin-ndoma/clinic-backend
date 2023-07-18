class ApplicationController < ActionController::API
  include ActionController::Cookies

  def current_user
    @current_user ||= Patient.find_by(id: session[:patient_id]) if session[:patient_id]
  end

  def authenticate_user
    unless current_user
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end
end
