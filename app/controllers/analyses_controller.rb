class AnalysesController < ApplicationController
  before_action :set_child
  before_action :set_analysis, only: %i[ show edit update destroy ]

  # GET /analyses or /analyses.json
  def index
    @analyses = @child.analyses.includes(:meal, :allergy)
  end

  # GET /analyses/1 or /analyses/1.json
  def show
  end

  # GET /analyses/new
  def new
    @analysis = @child.analyses.new
    @meals = @child.meals.includes(:food)
    @allergies = @child.allergies
  end

  # GET /analyses/1/edit
  def edit
    @meals = @child.meals.includes(:food)
    @allergies = @child.allergies
  end

  # POST /analyses or /analyses.json
  def create
    @analysis = @child.analyses.new(analysis_params)

    respond_to do |format|
      if @analysis.save
        format.html { redirect_to child_analysis_url(@child, @analysis), notice: "Analysis was successfully created." }
        format.json { render :show, status: :created, location: @analysis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analyses/1 or /analyses/1.json
  def update
    respond_to do |format|
      if @analysis.update(analysis_params)
        format.html { redirect_to child_analysis_url(@child, @analysis), notice: "Analysis was successfully updated." }
        format.json { render :show, status: :ok, location: @analysis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyses/1 or /analyses/1.json
  def destroy
    @analysis.destroy!

    respond_to do |format|
      format.html { redirect_to child_analyses_path(@child), notice: "Analysis was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_analysis
    @analysis = @child.analyses.includes(:meal, :allergy).find(params[:id])
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
  def analysis_params
    params.require(:analysis).permit(:meal_id, :date, :findings, :recommendations, :allergy_id)
  end
end
