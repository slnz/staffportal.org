class Week < ActiveRecord::Base
  attr_accessible :date_start, :date_finished

  def date_start=(date)
    if date.instance_of?(Date)
      self.date_finished = date + 1.week - 1.day
    end
    super(date)
  end

  def name
    "#{date_start.strftime('%a, %d %b %y')} - " +
    "#{date_finished.strftime('%a, %d %b %y')}"
  end

  def end_name
    "#{date_finished.strftime('%d %b')}"
  end
end
