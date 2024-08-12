class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child_by_params_id, only: %i[ show edit update destroy ]
  before_action :set_selected_child, only: %i[details]

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
        format.html { redirect_to children_path, notice: "Child was successfully created." }
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
      format.html { redirect_to children_path, notice: "Child was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def select
    @selected_child = current_user.children.find(params[:child_id])
    session[:selected_child_id] = @selected_child.id
    redirect_to details_child_path(@selected_child)
  end

  def details
    @children = current_user.children

    @q_meals = @child.meals.ransack(params[:q_meals])
    @meals = @q_meals.result.includes(:food).order(date: :desc).page(params[:page]).per(5)

    @q_allergies = @child.allergies.ransack(params[:q_allergies])
    @allergies = @q_allergies.result.order(detected_date: :desc).page(params[:page]).per(4)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_child_by_params_id
    @child = current_user.children.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to children_path, alert: "Child not found."
  end

  def set_selected_child
    if session[:selected_child_id]
      @child = current_user.children.find(session[:selected_child_id])
    else
      redirect_to children_path, alert: "Please select a child first."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to children_path, alert: "Please select a child first."
  end

  # Only allow a list of trusted parameters through.
  def child_params
    params.require(:child).permit(:name, :date_of_birth, :gender)
  end
end
