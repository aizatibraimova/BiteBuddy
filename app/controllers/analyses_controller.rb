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
  end

  # GET /analyses/1/edit
  def edit
  end

  # POST /analyses or /analyses.json
  def create
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    data_service = ChildDataService.new(@child, start_date, end_date)
    prepared_data = data_service.prepare_data

    analysis_service = OpenAiAnalysisService.new(prepared_data[:meals], prepared_data[:allergies])
    @analysis_result = analysis_service.analyze

    # Save the analysis result in the database
    @analysis = @child.analyses.new(
      meal_id: prepared_data[:meals].first&.id, # Adjust as necessary
      allergy_id: prepared_data[:allergies].first&.id, # Adjust as necessary
      date: Date.today,
      findings: @analysis_result[:findings],
      recommendations: @analysis_result[:recommendations]
    )

    if @analysis.save
      redirect_to child_analyses_path(@child), notice: "Analysis was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def fetch_meals_and_allergies
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    meals = @child.meals.where(date: start_date..end_date)
    allergies = @child.allergies.where(detected_date: start_date..end_date)

    render json: {
      meals: meals.map { |meal| { id: meal.id, name: meal.name } },
      allergies: allergies.map { |allergy| { id: allergy.id, name: allergy.name } },
      selected_meal_id: meals.first&.id,
      selected_allergy_id: allergies.first&.id
    }
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
    @analysis = @child.analyses.find(params[:id])
  end

  def set_child
    @child = current_user.children.find(params[:child_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to children_path, alert: "Please select a child first."
  end

  # Only allow a list of trusted parameters through.
  def analysis_params
    params.require(:analysis).permit(:meal_id, :date, :findings, :recommendations, :allergy_id)
  end
end
