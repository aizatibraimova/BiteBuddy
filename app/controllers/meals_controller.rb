class MealsController < ApplicationController
  before_action :set_child
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  def index
    @child = current_user.children.find(params[:child_id])

    @breadcrumbs = [
      { content: "Home", href: authenticated_root_path },
      { content: "Children", href: children_path },
      { content: @child.name, href: details_child_path(@child) },
      { content: "Meals", href: child_meals_path(@child) },
    ]
    @q = @child.meals.ransack(params[:q])
    @meals = @q.result(distinct: true).page(params[:page]).per(10)
  end

  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = @child.meals.new
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    @meal = @child.meals.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to details_child_path(@child), notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to details_child_path(@child), notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy!

    respond_to do |format|
      format.html { redirect_to details_child_path(@child), notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = @child.meals.find(params[:id])
  end

  def set_child
    unless session[:selected_child_id]
      redirect_to children_path, alert: "Please select a child first."
      return
    end
    @child = current_user.children.find(session[:selected_child_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to children_path, alert: "Please select a child first."
  end

  # Only allow a list of trusted parameters through.
  def meal_params
    params.require(:meal).permit(:food_id, :notes, :date, :quantity)
  end
end
