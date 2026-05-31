class MaintenanceRecordsController < ApplicationController
  before_action :set_record, only: [:show, :update, :destroy] # Use before_action [cite: 43]

  def index
    records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc) # includes equipment, order desc [cite: 41]
    records = records.where(equipment_id: params[:equipment_id]) if params[:equipment_id].present? # filter [cite: 41]

    render json: records.as_json(include: { equipment: { only: :name } }), status: :ok # Include equipment name [cite: 41]
  end

  def show
    render json: @record.as_json(include: { equipment: { only: :name } }), status: :ok # Include equipment name [cite: 42]
  end

  def create
    record = MaintenanceRecord.new(record_params)
    if record.save
      render json: record, status: :created
    else
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @record.update(record_params)
      render json: @record, status: :ok
    else
      render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    head :no_content
  end

  private

  def set_record
    @record = MaintenanceRecord.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance Record not found" }, status: :not_found
  end

  def record_params
    params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
  end
end
