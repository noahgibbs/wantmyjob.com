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
    next_question, @answer_type, question_job = current_user.profile.next_question

    if next_question == nil
      redirect_to(:action => :enter)
      return
    end

    @question = next_question
    @answers = next_question.question_answers.order("id ASC")
    if @answer_type == Answer::PERFECT_COMPANY_ANSWER
      @template = "perfect_co_answer"
      @co_name = "your perfect job"
    elsif @answer_type == Answer::COMPANY_ANSWER
      @job = question_job
      @template = "co_answer"
      @co_name = @job.employer
    else
      raise "Unimplemented!"
    end
  end

  def answer_post
    pa = params[:answer]

    if params[:commit] =~ /skip/i
      pa.keys.each do |key|
        if key =~ /^data\d(_\d)?$/
          pa.delete key
        end
      end

      a = Answer.new pa
      a.save!

      redirect_to_next_step
      return
    end

    # Combine virtual sub-attributes
    (1..Answer::NUM_DATA_FIELDS).each do |data_idx|
      # nil and the empty string both become 0
      pa["data#{data_idx}"] = pa["data#{data_idx}"].to_i
    end 
    # Add each sub-key to its corresponding real attribute
    pa.keys.each do |key|
      if key =~ /^data\d_\d$/
        pa[key[0..-3]] += pa[key].to_i
        pa.delete key
      end
    end

    a = Answer.new pa
    a.save!

    redirect_to_next_step
  end

  def enter_post
    q = question
    q.created_by = current_user.profile.id
    q.completed = true
    q.verified = false
    q.question_type = Question::EMPLOYER_QUESTION
    ans = answers
    ActiveRecord::Base.transaction do
      q.save!  # Transaction because this saves all answers
    end
    flash[:notice] = "Your question has been submitted.  After a moderator " +
      "checks it, it will be added to the site."
    redirect_to :action => :enter
  end

  # Action to verify questions, checked from the index view
  def verify_questions
    pq = params[:question]
    return malformed_url_error unless pq
    num_saved = 0
    pq.keys.each do |idx|
      q = Question.find(idx)
      next unless pq[idx][:verified] == "1"
      q.verified = true
      q.save!
      num_saved += 1
    end

    flash[:notice] = "Verified #{num_saved} questions successfully."
    redirect_to :action => :index
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
