class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[ show edit update destroy ]

  helper FoodsHelper

  # GET /foods or /foods.json
  def index
    @breadcrumbs = [
      { content: "Home", href: authenticated_root_path },
      { content: "Foods", href: foods_path },
    ]

    @q = policy_scope(current_user.foods).ransack(params[:q])
    @foods = @q.result(distinct: true).page(params[:page]).per(10)
  end

  # GET /foods/1 or /foods/1.json
  def show
    authorize @food
  end

  # GET /foods/new
  def new
    @food = current_user.foods.build
    authorize @food
  end

  # GET /foods/1/edit
  def edit
    authorize @food
  end

  # POST /foods or /foods.json
  def create
    @food = current_user.foods.build(food_params)
    authorize @food

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: "Food was successfully created." }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    authorize @food
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: "Food was successfully updated." }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    authorize @food
    @food.destroy!

    respond_to do |format|
      format.html { redirect_to foods_url, notice: "Food was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = current_user.foods.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :category)
  end
end
