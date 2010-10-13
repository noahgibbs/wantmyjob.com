class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin, :except => [:answer, :answer_post,
                                             :enter, :enter_post]

  respond_to :html

  def answer
  end

  def answer_post
  end

  def enter
    @question = Question.new
    @answers = (1..Question::MAX_ANSWERS).map { QuestionAnswer.new }
  end

  def enter_post
  end

  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all

    respond_with @questions
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_with @question
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_with @question
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_with nil, :location => questions_url, :status => :ok
  end
end
