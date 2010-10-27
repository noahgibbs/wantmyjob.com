class UtterlyNaiveMatch < ActiveRecord::Base

  def self.create_matches_for(profiles = :all, jobs = :all)
    profiles = Profile.all if profiles == :all
    jobs = Job.all if jobs == :all

    UtterlyNaiveMatch.delete_all

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
        m = UtterlyNaiveMatch.new(:profile_id => p.id, :job_id => j.id,
                                  :howgood => goodness_of_match)
        m.save!
      end
    end
  end

  def self.perfect_co_match_answers(p_answers, j_answers)
    p_map = {}
    p_answers.each {|a| p_map[a.question_id] = a}
    j_map = {}
    j_answers.each {|a| j_map[a.question_id] = a}

    all_q_ids = (p_map.keys + j_map.keys).uniq

    all_q_ids.each do |q_id|
      next unless p_map[q_id] && j_map[q_id]

      
    end
  end

end
