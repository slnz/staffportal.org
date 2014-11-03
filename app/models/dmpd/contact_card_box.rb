class Dmpd::ContactCardBox < ActiveRecord::Base
  validates :week_id, uniqueness: { scope: :user_id }
  validates :appointment_no_support, presence: true
  validates :appointment_set, presence: true
  validates :call_back_for_appointment, presence: true
  validates :call_back_for_contacts, presence: true
  validates :call_back_for_decision, presence: true
  validates :call_back_in_a_year, presence: true
  validates :called_no_appointment_set, presence: true
  validates :contact_cards, presence: true
  validates :maintainance, presence: true
  validates :maintainance_done, presence: true
  validates :new_ministry_partner, presence: true
  validates :not_back_until, presence: true
  validates :office_phone_only, presence: true
  validates :on_list, presence: true
  validates :research, presence: true
  validates :would_have_met, presence: true
  belongs_to :user
  belongs_to :week

  def total
    appointment_no_support.to_i +
    appointment_set.to_i +
    call_back_for_appointment.to_i +
    call_back_for_contacts.to_i +
    call_back_for_decision.to_i +
    call_back_in_a_year.to_i +
    called_no_appointment_set.to_i +
    contact_cards.to_i +
    maintainance.to_i +
    maintainance_done.to_i +
    new_ministry_partner.to_i +
    not_back_until.to_i +
    office_phone_only.to_i +
    on_list.to_i +
    research.to_i +
    would_have_met.to_i
  end

  def contact_total
    contact_cards.to_i +
    not_back_until.to_i +
    office_phone_only.to_i +
    research.to_i
  end

  def call_back_total
    call_back_for_appointment.to_i +
    call_back_for_decision.to_i  +
    call_back_for_contacts.to_i
  end

  def appointment_total
    appointment_set.to_i +
    called_no_appointment_set.to_i +
    appointment_no_support.to_i +
    new_ministry_partner.to_i
  end

  def future_total
    call_back_in_a_year.to_i +
    would_have_met.to_i +
    on_list.to_i
  end

  def mpm_total
    maintainance +
    maintainance_done.to_i
  end

  def used_contacts_total
    call_back_for_decision.to_i +
    call_back_for_contacts.to_i +
    appointment_set.to_i +
    called_no_appointment_set.to_i +
    appointment_no_support.to_i +
    new_ministry_partner.to_i
  end

  def created_at_print
    created_at.strftime('%a, %d %b %y')
  end
end
