class AllergiesController < ApplicationController
  before_action :set_child
  before_action :set_allergy, only: %i[ show edit update destroy ]

  helper AllergiesHelper

  # GET /allergies or /allergies.json
  def index
    @allergies = @child.allergies
  end

  # GET /allergies/1 or /allergies/1.json
  def show
  end

  # GET /allergies/new
  def new
    @allergy = @child.allergies.new
  end

  # GET /allergies/1/edit
  def edit
  end

  # POST /allergies or /allergies.json
  def create
    @allergy = @child.allergies.new(allergy_params)

    respond_to do |format|
      if @allergy.save
        format.html { redirect_to details_child_path(@child), notice: "Allergy was successfully created." }
        format.json { render :show, status: :created, location: @allergy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /allergies/1 or /allergies/1.json
  def update
    respond_to do |format|
      if @allergy.update(allergy_params)
        format.html { redirect_to details_child_path(@child), notice: "Allergy was successfully updated." }
        format.json { render :show, status: :ok, location: @allergy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allergies/1 or /allergies/1.json
  def destroy
    @allergy.destroy!

    respond_to do |format|
      format.html { redirect_to details_child_path(@child), notice: "Allergy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_allergy
    @allergy = @child.allergies.find(params[:id])
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
  def allergy_params
    params.require(:allergy).permit(:description, :severity, :child_id, :detected_date, :notes)
  end
end
