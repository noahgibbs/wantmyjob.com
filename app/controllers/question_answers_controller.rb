class QuestionAnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin

  respond_to :html

  # GET /question_answers
  # GET /question_answers.xml
  def index
    @question_answers = QuestionAnswer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @question_answers }
    end
  end

  # GET /question_answers/1
  # GET /question_answers/1.xml
  def show
    @question_answer = QuestionAnswer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question_answer }
    end
  end

  # GET /question_answers/new
  # GET /question_answers/new.xml
  def new
    @question_answer = QuestionAnswer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question_answer }
    end
  end

  # GET /question_answers/1/edit
  def edit
    @question_answer = QuestionAnswer.find(params[:id])
  end

  # POST /question_answers
  # POST /question_answers.xml
  def create
    @question_answer = QuestionAnswer.new(params[:question_answer])

    respond_to do |format|
      if @question_answer.save
        format.html { redirect_to(@question_answer, :notice => 'Question answer was successfully created.') }
        format.xml  { render :xml => @question_answer, :status => :created, :location => @question_answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /question_answers/1
  # PUT /question_answers/1.xml
  def update
    @question_answer = QuestionAnswer.find(params[:id])

    respond_to do |format|
      if @question_answer.update_attributes(params[:question_answer])
        format.html { redirect_to(@question_answer, :notice => 'Question answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /question_answers/1
  # DELETE /question_answers/1.xml
  def destroy
    @question_answer = QuestionAnswer.find(params[:id])
    @question_answer.destroy

    respond_to do |format|
      format.html { redirect_to(question_answers_url) }
      format.xml  { head :ok }
    end
  end
end
