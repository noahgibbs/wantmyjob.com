class Note < ActiveRecord::Base
  NOTE_TYPE_DAILY_FEED_STATS = 1

  scope :daily_feed, where(:note_type => NOTE_TYPE_DAILY_FEED_STATS).
        order("updated_at DESC")

  def self.generate_daily_feed_stats
    n = Note.new(:title => "Feed Stats for #{Date.today}",
                 :note_type => DAILY_FEED_STATS,
                 :body => <<END
Devise Users: #{User.count}
Profiles: #{Profile.count}
Demo Profiles: #{Profile.where(:demo => true).count}
Valid Questions: #{Question.verified.count}
Waiting Questions: #{Question.unverified.count}
Answers: #{Answer.count}
END)
    n.save!
  end
end
