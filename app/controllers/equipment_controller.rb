class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :update, :destroy] # Use before_action [cite: 39]

  def index
    # includes(:category) prevents N+1 [cite: 37, 59]
    equipment_scope = Equipment.includes(:category).order(:name) 
    equipment_scope = equipment_scope.where(status: params[:status]) if params[:status].present? # Support filtering [cite: 37]

    render json: equipment_scope.as_json(include: { category: { only: :name } }), status: :ok # Include category name [cite: 37]
  end

  def show
    # Include category and all maintenance records ordered by performed_at descending [cite: 38]
    render json: @equipment.as_json(
      include: {
        category: { only: :name },
        maintenance_records: { order: { performed_at: :desc } }
      }
    ), status: :ok
  end

  def create
    equipment = Equipment.new(equipment_params)
    if equipment.save
      render json: equipment, status: :created
    else
      render json: { errors: equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @equipment.update(equipment_params)
      render json: @equipment, status: :ok
    else
      render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy # Cascades due to model setup [cite: 39]
    head :no_content
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
  end
end

