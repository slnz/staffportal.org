class AppointmentSetRecord < ActiveRecord::Base
  # attr_accessible :amount, :asked_for_contacts, :date_of_appointment,
  #                 :date_set, :first_name, :gift_confirmed_date, :gift_date,
  #                 :last_name, :number_of_contacts_received, :support,
  #                 :thank_you_posted, :frequency
  belongs_to :user
  belongs_to :date_set_week, class_name: Week
  belongs_to :date_of_appointment_week, class_name: Week
  belongs_to :gift_date_week, class_name: Week
  belongs_to :gift_confirmed_date_week, class_name: Week
  belongs_to :contact
  validates_presence_of :date_of_appointment, :contact
  after_create :update_contact_status

  def self.pledge_frequencies
    {
      'Special' => (0.0).to_d,
      'Weekly' => (0.23076923076923).to_d,
      'Fortnightly' => (0.46153846153846).to_d,
      'Monthly' => (1.0).to_d,
      'Bi-Monthly' => (2.0).to_d,
      'Quarterly' => (3.0).to_d,
      'Semi-Annual' => (6.0).to_d,
      'Annual' => (12.0).to_d,
      'Biennial' => (24.0).to_d
    }
  end

  def pretty_amount
    if frequency.nil? || amount.nil?
      ''
    else
      "#{ActionController::Base.helpers.
                                number_to_currency amount, precision: 0}" +
      "/#{AppointmentSetRecord::pledge_frequencies.invert[frequency].downcase}"
    end
  end

  def date_set=(date)
    self.date_set_week = get_week(date)
    super(date)
  end

  def date_of_appointment=(date)
    self.date_of_appointment_week = get_week(date)
    super(date)
  end

  def gift_date=(date)
    self.gift_date_week = get_week(date)
    super(date)
  end

  def gift_confirmed_date=(date)
    self.gift_confirmed_date_week = get_week(date)
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
    if frequency == 0 || frequency.nil? || amount.nil?
      self.monthly = 0
    else
      self.monthly = amount / (frequency)
    end
  end

  def name
    # "#{first_name} #{last_name}"
  end

  def created_at_print
    created_at.strftime('%a, %d %b %y')
  end

  protected

  def update_contact_status
    contact.appointment_set!
  end

  def get_week(date)
    Week.where('date_start <= ? and date_finished >= ?',
               date,
               date).first unless date == ''
  end
end
