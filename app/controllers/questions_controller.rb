class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin,
                  :except => [:answer, :answer_post,
                              :enter, :enter_post]

  respond_to :html

  expose(:questions) { Question.scoped }
  expose(:question)
  expose(:answers) do
    if params[:answers]
      params[:answers].select {|s| !s[:text].empty?}.map do |a|
        question.question_answers << QuestionAnswer.new(a)
      end
    else
      (1..Question::MAX_ANSWERS).map { QuestionAnswer.new }
    end
  end

  def answer
  end

  def answer_post
  end

  def enter_post
    q = question
    ans = answers
    ActiveRecord::Base.transaction do
      q.save!  # Transaction because this saves all answers
    end
    redirect_to questions_path
  end

  # GET /questions
  def index
    respond_with questions
  end

  # POST /questions
  def create
    if question.save
      redirect_to(question, :notice => 'Question was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /questions/1
  def update
    if question.update_attributes(params[:question])
      redirect_to(question, :notice => 'Question was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /questions/1
  def destroy
    question.destroy
    respond_with question
  end
end
