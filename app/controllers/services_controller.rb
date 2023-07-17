class ServicesController < ApplicationController
    before_action :authenticate_doctor, except: [:index]
  
    def index
      services = Service.all
      render json: services
    end
  
    def show
      service = Service.find_by(id: params[:id])
      if service
        render json: service
      else
        render json: { error: "Service not found" }, status: :not_found
      end
    end
  
    def create
      service = Service.new(service_params)
      if service.save
        render json: service, status: :created
      else
        render json: { error: service.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      service = Service.find_by(id: params[:id])
      if service
        if service.update(service_params)
          render json: service
        else
          render json: { error: service.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Service not found" }, status: :not_found
      end
    end
  
    def destroy
      service = Service.find_by(id: params[:id])
      if service
        service.destroy
        head :no_content
      else
        render json: { error: "Service not found" }, status: :not_found
      end
    end
  
    private
  
    def service_params
      params.require(:service).permit(:name, :description)
    end
  
    def authenticate_doctor
      unless current_user && current_user.doctor?
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    end
  end
  