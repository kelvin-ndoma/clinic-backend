class PatientsController < ApplicationController
  def create
    patient = Patient.find_by(email: params[:email])
    if patient && patient.authenticate(params[:password])
      session[:patient_id] = patient.id
      render json: patient
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def show
    patient = Patient.find_by(id: params[:id])
    if patient
      render json: patient
    else
      render json: { error: "Patient not found" }, status: :not_found
    end
  end

  def appointments
    patient = Patient.find_by(id: params[:id])
    if patient
      appointments = patient.appointments
      render json: appointments
    else
      render json: { error: "Patient not found" }, status: :not_found
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :email, :password)
  end
end
