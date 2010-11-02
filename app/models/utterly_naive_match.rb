class UtterlyNaiveMatch < ActiveRecord::Base
  belongs_to :job
  belongs_to :profile

  def self.create_matches_for(profiles = :all, jobs = :all)
    profiles = [profiles] if profiles.kind_of? Profile
    jobs = [jobs] if jobs.kind_of? Job
    jobs = Job.all if jobs == :all

    delete_hash = {}

    if profiles == :all
      profiles = Profile.all
    else
      delete_hash.merge!(:profile_id => profiles.map(&:id))
    end

    if jobs == :all
      jobs = Job.all
    else
      delete_hash.merge!(:job_id => jobs.map(&:id))
    end

    UtterlyNaiveMatch.where(delete_hash).delete_all

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

    total_match = total_importance = 0

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

  # Pos is the number of positive (true) ratings
  # N is the total number of ratings
  # Power is the statistical power - 0.10 for 95% chance, 0.05 for 97.5%, etc
  #
  # This is the wilson score confidence interval (lower bound) for a given
  # number of samples, proportion of samples and statistical power.
  #
  # Based on http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
  #
  # TODO: move this to some kind of utility module
  def self.wilson_score(pos, n, power)
    return 0.0 if n == 0

    z = Statistics2.pnormaldist(1.0 - power/2.0)
    phat = 1.0 * pos / n

    divisor = (1 + z * z / n)
    center = phat + z * z / (2 * n)
    radius = z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n)

    # This is lower bound.  Change - to + for upper bound
    (center - radius) / divisor
  end

  # This is how confident we are of a good match based on simple criteria
  # for answers.  A better match would take the min *and* max and get
  # a by-question confidence, with how wide the interval was.  This is
  # not that matching algorithm, though that one would rock.
  def match_confidence
    UtterlyNaiveMatch.wilson_score(self.matching, self.match_out_of, 0.05)
  end

end
