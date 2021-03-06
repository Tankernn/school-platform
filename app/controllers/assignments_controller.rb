class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:edit, :update]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = current_user.assignments
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    check_permissions

    respond_to do |format|
      if @assignment.save
        flash[:success] = 'Assignment was successfully created.'
        format.html { redirect_to @assignment }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        flash[:success] = 'Assignment was successfully updated.'
        format.html { redirect_to @assignment }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      flash[:success] = 'Assignment was successfully destroyed.'
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      allowed = [:name, :description, :due_at]

      # Don't allow moving an assignment to a different course
      allowed += [:course_id] if action_name == 'create'

      params.require(:assignment).permit(*allowed)
    end

    def check_permissions
      redirect_to root_url unless current_user.is_course_teacher?(@assignment.course)
    end
end
