class AppointmentsController < ApplicationController
  before_action :authenticate_user
  
  def index
    appointments = current_user.appointments
    render json: appointments
  end

  def show
    appointment = current_user.appointments.find_by(id: params[:id])
    if appointment
      render json: appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def create
    appointment = current_user.appointments.new(appointment_params)
    if appointment.save
      render json: appointment, status: :created
    else
      render json: { error: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    appointment = current_user.appointments.find_by(id: params[:id])
    if appointment
      if appointment.update(appointment_params)
        render json: appointment
      else
        render json: { error: appointment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def destroy
    appointment = current_user.appointments.find_by(id: params[:id])
    if appointment
      appointment.destroy
      head :no_content
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:service, :datetime)
  end

  def authenticate_user
    unless current_user
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end
end
