class SessionsController < ApplicationController
    def create
      patient = Patient.find_by(email: params[:email])
      if patient && patient.authenticate(params[:password])
        session[:patient_id] = patient.id
        render json: patient
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  
    def destroy
      session.delete(:patient_id)
      head :no_content
    end
  
    def current_user
      if session[:patient_id]
        patient = Patient.find_by(id: session[:patient_id])
        render json: patient
      else
        render json: { error: "No current user" }, status: :unauthorized
      end
    end
  end
  