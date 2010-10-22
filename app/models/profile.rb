class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :jobs

  def next_question
    my_jobs = jobs
    question_ids = Question.verified.select(:id).map(&:id).sample(5)
    questions = Question.find(question_ids)
    answers = Answer.where(:question_id => question_ids,
                           :job_id => (my_jobs.map(&:id) + [nil]))

    co_answers = answers.select {|a| a.answer_type == Answer::COMPANY_ANSWER}
    n_questions = questions.count
    n_pc_answers = answers.size - co_answers.size

    # There should be 5 * (1 + num_jobs) total possible answers here.
    # We want to randomize proportionally to the non-answered stuff.
    # So every combination with no answer is a 'chance', and we count
    # perfect-company chances and regular-company chances.

    co_chances = n_questions * jobs.size - co_answers.size
    pc_chances = n_questions - n_pc_answers

    co_odds = (0.0 + co_chances) / (0.0 + co_chances + pc_chances)

    use_perfect = rand() > co_odds

    job = nil
    if use_perfect
      used_questions = answers.select {|a| a.answer_type == Answer::PERFECT_COMPANY_ANSWER }.map(&:question_id)

      question = Question.find((questions.map(&:id) - used_questions).sample)
      answer_type = Answer::PERFECT_COMPANY_ANSWER
    else
      used_pairs = co_answers.map {|a| [a.question_id, a.job_id]}

      # All pairs is the cartesian product of questions with jobs
      all_pairs = []
      questions.each {|q| jobs.each {|j| all_pairs << [q.id, j.id]}}

      question_pair = (all_pairs - used_pairs).sample
      return [nil, nil, nil] if(!question_pair || question_pair == [])
      question = Question.find(question_pair[0])
      answer_type = Answer::COMPANY_ANSWER
      job = Job.find(question_pair[1])
    end

    [question, answer_type, job]
  end
end
