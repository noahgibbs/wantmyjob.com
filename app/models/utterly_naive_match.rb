class UtterlyNaiveMatch < ActiveRecord::Base

  def self.create_matches_for(profiles = :all, jobs = :all)
    jobs = Job.all if jobs == :all

    if profiles == :all
      profiles = Profile.all
      UtterlyNaiveMatch.delete_all
    else
      # If I try to use this with only selected profiles, this may
      # utterly overload the database's IN() functionality.  So
      # this will probably get rewritten when I try to scale it.
      UtterlyNaiveMatch.where(:profile_id => profiles.map(&:id),
                              :job_id => jobs.map(&:id)).delete_all
    end

    profiles.each do |p|
      perfect_answers = Answer.where(:profile_id => p.id,
                                :answer_type => Answer::PERFECT_COMPANY_ANSWER).
                               order("question_id ASC")
      jobs.each do |j|
        job_answers = Answer.where(:job_id => j.id,
                                   :answer_type => Answer::COMPANY_ANSWER).
                             order("question_id ASC")
        goodness_of_match = self.perfect_co_match_answers(perfect_answers,
                                                          job_answers)
        m = UtterlyNaiveMatch.new({:profile_id => p.id, :job_id => j.id}.
                                  merge(goodness_of_match))
        m.save!
      end
    end
  end

  IMPORTANCE = {
    1 => 0,  # Not at all
    2 => 1,  # Somewhat
    3 => 3,  # Very
    4 => 12  # Required
  }

  def self.perfect_co_match_answers(p_answers, j_answers)
    p_map = {}
    p_answers.each {|a| p_map[a.question_id] = a}
    j_map = {}
    j_answers.each {|a| j_map[a.question_id] = a}

    all_q_ids = (p_map.keys + j_map.keys).uniq
    skipped_ids = []

    all_q_ids.each do |q_id|
      next unless p_map[q_id] && j_map[q_id]

      answer = j_map[q_id].data1
      if answer == 0  # Skipped questions don't count
        skipped_ids += [q_id]
        next
      end

      importance = IMPORTANCE[p_map[q_id].data2]
      total_importance += importance

      # See if that answer was checked
      if((1 << (answer - 1)) & p_map[q_id].data1)
        total_match += importance
      end
    end

    # Return an attributes hash
    { :matching => total_match, :match_out_of => total_importance,
      :question_overlap => all_q_ids.length - skipped_ids.length}
  end

end
