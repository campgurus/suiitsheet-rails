class AnswersController < ApplicationController
  before_action :get_question
  before_action :set_answer, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update destroy]

  # GET /answers
  def index
    @answers = @question.answers

    render json: @answers
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  def new
    @answer = @question.answers.build
  end

  # POST /answers
  def create
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id

    if @answer.save
      render json: @answer, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private
    def get_question
      @question = Question.find(params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = @question.answers.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:body, :question_id)
    end

end
