class AnalysesController < ApplicationController
  before_action :set_child
  before_action :set_analysis, only: %i[show edit update destroy]

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
    @analysis = @child.analyses.new(analysis_params)
    @analysis.child = @child

    # Find meal and allergy for the selected child
    meal = @child.meals.find(params[:analysis][:meal_id])
    allergy = @child.allergies.find(params[:analysis][:allergy_id])
    @analysis.meal = meal
    @analysis.allergy = allergy

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
    meal = @child.meals.find(params[:analysis][:meal_id])
    allergy = @child.allergies.find(params[:analysis][:allergy_id])
    @analysis.meal = meal
    @analysis.allergy = allergy

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

  # Fetch meals and allergies for analysis within the given time frame
  def fetch_meals_and_allergies
    time_frame = params[:time_frame]

    start_date = case time_frame
      when "2_days"
        2.days.ago
      when "1_week"
        1.week.ago
      when "2_weeks"
        2.weeks.ago
      when "1_month"
        1.month.ago
      else
        nil
      end

    if start_date
      meals_query = @child.meals.where("date >= ?", start_date).ransack(params[:q])
      allergies_query = @child.allergies.where("detected_date >= ?", start_date).ransack(params[:q])

      meals = meals_query.result.includes(:food)
      allergies = allergies_query.result

      meals_data = meals.map { |meal| { id: meal.id, food_name: meal.food.name, date: meal.date, notes: meal.notes } }
      allergies_data = allergies.map { |allergy| { id: allergy.id, description: allergy.description, detected_date: allergy.detected_date, notes: allergy.notes } }

      openai_service = OpenAIService.new(ENV["OPENAI_API_KEY"])
      analysis_result = openai_service.analyze_data(meals_data, allergies_data)
      findings, recommendations = parse_analysis(analysis_result)

      render json: {
        meals: meals_data,
        allergies: allergies_data,
        findings: findings,
        recommendations: recommendations,
      }
    else
      render json: { meals: [], allergies: [], findings: "", recommendations: "No data available for the selected time frame." }
    end
  end

  private

  def set_analysis
    @analysis = @child.analyses.find(params[:id])
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

  def analysis_params
    params.require(:analysis).permit(:meal_id, :date, :findings, :recommendations, :allergy_id)
  end

  def parse_analysis(analysis_result)
    findings_marker = "Findings:"
    recommendations_marker = "Recommendations:"

    findings = analysis_result[/#{findings_marker}(.*?)#{recommendations_marker}/m, 1]&.strip || ""
    recommendations = analysis_result[/#{recommendations_marker}(.*)/m, 1]&.strip || ""

    return findings, recommendations
  end
end
