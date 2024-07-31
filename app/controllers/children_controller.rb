class ChildrenController < ApplicationController
  before_action :set_child, only: %i[ show edit update destroy details ]

  # GET /children or /children.json
  def index
    @children = current_user.children
  end

  # GET /children/1 or /children/1.json
  def show
  end

  # GET /children/new
  def new
    @child = Child.new
  end

  # GET /children/1/edit
  def edit
  end

  # POST /children or /children.json
  def create
    @child = current_user.children.build(child_params)

    respond_to do |format|
      if @child.save
        format.html { redirect_to @child, notice: "Child was successfully created." }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /children/1 or /children/1.json
  def update
    respond_to do |format|
      if @child.update(child_params)
        format.html { redirect_to child_url(@child), notice: "Child was successfully updated." }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1 or /children/1.json
  def destroy
    @child.destroy!

    respond_to do |format|
      format.html { redirect_to children_url, notice: "Child was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def select
    selected_child = current_user.children.find(params[:child_id])
    session[:selected_child_id] = params[:child_id]
    session[:selected_child_name] = selected_child.name
    redirect_to details_child_path(selected_child), notice: "Child selected successfully."
  end

  def details
    @meals = @child.meals.includes(:food)
    @allergies = @child.allergies
  end

  def fetch_meals_and_allergies
    time_frame = params[:time_frame]

    start_date = case time_frame
                 when '2_days'
                   2.days.ago
                 when '1_week'
                   1.week.ago
                 when '2_weeks'
                   2.weeks.ago
                 when '1_month'
                   1.month.ago
                 else
                   nil
                 end

    if start_date
      meals = @child.meals.where('date >= ?', start_date).includes(:food)
      allergies = @child.allergies.where('detected_date >= ?', start_date)

      render json: {
        meals: meals.map { |meal| { id: meal.id, food_name: meal.food.name, date: meal.date } },
        allergies: allergies.map { |allergy| { id: allergy.id, description: allergy.description, detected_date: allergy.detected_date } }
      }
    else
      render json: { meals: [], allergies: [] }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_child
    @child = current_user.children.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def child_params
    params.require(:child).permit(:name, :date_of_birth, :gender)
  end
end
