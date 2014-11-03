class Dmpd::Week < ActiveRecord::Base
  paginates_per 10

  def date_start=(date)
    self.date_finished = date + 1.week - 1.day if date.instance_of?(Date)
    super(date)
  end

  def name
    "#{date_start.strftime('%a, %d %b %y')} - " \
    "#{date_finished.strftime('%a, %d %b %y')}"
  end

  def end_name
    "#{date_finished.strftime('%d %b')}"
  end
end
