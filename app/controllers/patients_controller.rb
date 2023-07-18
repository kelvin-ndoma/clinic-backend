class PatientsController < ApplicationController
  def create
    patient = Patient.new(patient_params)
    if patient.save
      session[:patient_id] = patient.id
      render json: patient, status: :created
    else
      render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
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

  def update
    patient = Patient.find_by(id: params[:id])
    if patient
      if patient.update(patient_params)
        render json: patient
      else
        render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Patient not found" }, status: :not_found
    end
  end

  def destroy
    patient = Patient.find_by(id: params[:id])
    if patient
      patient.destroy
      head :no_content
    else
      render json: { error: "Patient not found" }, status: :not_found
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :email, :password)
  end
end
