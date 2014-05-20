class ContactCardBox < ActiveRecord::Base
  validates_uniqueness_of :week_id, scope: :user_id
  validates_presence_of :appointment_no_support, :appointment_set,
                        :call_back_for_appointment, :call_back_for_contacts,
                        :call_back_for_decision, :call_back_in_a_year,
                        :called_no_appointment_set, :contact_cards,
                        :maintainance, :maintainance_done,
                        :new_ministry_partner, :not_back_until,
                        :office_phone_only, :on_list, :research, :would_have_met
  attr_accessible :appointment_no_support, :appointment_set,
                  :call_back_for_appointment, :call_back_for_contacts,
                  :call_back_for_decision, :call_back_in_a_year,
                  :called_no_appointment_set, :contact_cards, :maintainance,
                  :maintainance_done, :new_ministry_partner, :not_back_until,
                  :office_phone_only, :on_list, :research, :would_have_met,
                  :week_id
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
