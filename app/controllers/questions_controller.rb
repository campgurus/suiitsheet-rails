class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update destroy]

  # GET /questions
  def index
    if params[:search] && params[:search].strip.length > 0
      @questions = Question.search_question(params[:search])
    else
      @questions = Question.all
    end
    render json: @questions.order(updated_at: :desc), include: [:answers]
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:body, answers_attributes: [:id, :body, :_destroy])
    end
end
