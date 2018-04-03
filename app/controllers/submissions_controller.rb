class SubmissionsController < ApplicationController
  before_action :set_assignment, only: [:create, :new, :index]
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :check_view_permission, only: [:show]
  before_action :check_group_membership, only: [:update, :edit]
  before_action :check_assignment_membership, only: [:create]

  # GET /assignments/1/submissions
  # GET /assignments/1/submissions.json
  def index
    @submissions = @assignment.submissions
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /assignments/1/submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /assignments/1/submissions
  # POST /assignments/1/submissions.json
  def create
    @submission = @assignment.submissions.new(submission_params)

    respond_to do |format|
      if @submission.save && (@submission.users << current_user)
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to assignment_submissions_url(@submission.assignment), notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_assignment
      @assignment = Assignment.find(params[:assignment_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:title, :description)
    end

    def check_view_permission
      redirect_to root_url unless @submission.users.include?(current_user) || @submission.assignment.course.users.merge(CourseParticipation.teachers).include?(current_user)
    end

    def check_group_membership
      redirect_to root_url unless @submission.users.include?(current_user)
    end

    def check_assignment_membership
      redirect_to root_url unless current_user.assignments.include?(@assignment)
    end
end
