class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy] # Use before_action [cite: 35]

  def index
    categories = Category.order(:name) # Ordered alphabetically [cite: 33]
    render json: categories, status: :ok
  end

  def show
    # Include equipment count [cite: 33]
    render json: @category.as_json.merge(equipment_count: @category.equipment.count), status: :ok
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created # 201 [cite: 23]
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity # 422 [cite: 23, 33]
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok # 200 [cite: 23]
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity # 422 [cite: 33]
    end
  end

  def destroy
    if @category.equipment.any?
      # 409 Conflict if equipment exists [cite: 17, 25, 34]
      render json: { error: "Cannot delete category. #{@category.equipment.count} equipment items still belong to it." }, status: :conflict 
    else
      @category.destroy
      head :no_content # 204 [cite: 23]
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found # 404 [cite: 23, 25, 35]
  end

  def category_params
    params.require(:category).permit(:name)
  end
end