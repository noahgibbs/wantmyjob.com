module ApplicationHelper

  def title(t)
    @title = t
  end

  def big_center_text(t)
    @big_center_text = t
  end

  def time_to_human(time)
    duration = Time.now - time
    intervals = [ :year, :month, :week, :day, :hour, :minute ]
    intervals.each do |interval|
      if duration > 2.send(interval)
        return (duration / 1.send(interval)).to_i.to_s + " " +
          interval.to_s + "s"
      end
    end
    return duration.to_i.to_s + " seconds"
  end
end
