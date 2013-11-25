class AppointmentSetRecord < ActiveRecord::Base
  attr_accessible :amount, :asked_for_contacts, :date_of_appointment, :date_set, :first_name, :gift_confirmed_date, :gift_date, :last_name, :number_of_contacts_received, :support, :thank_you_posted, :frequency
  belongs_to :user
  belongs_to :date_set_week, class_name: Week
  belongs_to :date_of_appointment_week, class_name: Week
  belongs_to :gift_date_week, class_name: Week
  belongs_to :gift_confirmed_date_week, class_name: Week
  validates_presence_of :first_name, :last_name, :date_set, :date_of_appointment

  def self.pledge_frequencies
    {
      "Special" => 0.0,
      "Weekly" => 0.23076923076923,
      "Fortnightly" => 0.46153846153846,
      "Monthly" => 1.0,
      "Bi-Monthly" => 2.0,
      "Quarterly" => 3.0,
      "Semi-Annual" => 6.0,
      "Annual" => 12.0,
      "Biennial" => 24.0
    }
  end

  def date_set=(date)
    self.date_set_week = Week.where('date_start <= ? and date_finished >= ?', date, date).first
    super(date)
  end

  def date_of_appointment=(date)
    self.date_of_appointment_week = Week.where('date_start <= ? and date_finished >= ?', date, date).first
    super(date)
  end

  def gift_date=(date)
    self.gift_date_week = Week.where('date_start <= ? and date_finished >= ?', date, date).first
    super(date)
  end

  def gift_confirmed_date=(date)
    self.gift_confirmed_date_week = Week.where('date_start <= ? and date_finished >= ?', date, date).first
    super(date)
  end

  def frequency=(new_frequency)
    super(new_frequency)
    set_monthly
  end

  def amount=(new_amount)
    super(new_amount)
    set_monthly
  end

  def set_monthly
    if self.frequency == 0 or self.frequency.nil?
      self.monthly = 0
    else 
      self.monthly = self.amount / (self.frequency)
    end
  end

end
