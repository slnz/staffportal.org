class ContactCardBox < ActiveRecord::Base
	validates_uniqueness_of :week_id, :scope => :user_id
	validates_presence_of  :appointment_no_support, :appointment_set, :call_back_for_appointment, :call_back_for_contacts, :call_back_for_decision, :call_back_in_a_year, :called_no_appointment_set, :contact_cards, :maintainance, :maintainance_done, :new_ministry_partner, :not_back_until, :office_phone_only, :on_list, :research, :would_have_met
  attr_accessible :appointment_no_support, :appointment_set, :call_back_for_appointment, :call_back_for_contacts, :call_back_for_decision, :call_back_in_a_year, :called_no_appointment_set, :contact_cards, :maintainance, :maintainance_done, :new_ministry_partner, :not_back_until, :office_phone_only, :on_list, :research, :would_have_met, :week_id
  belongs_to :user
  belongs_to :week

  def total
  	self.appointment_no_support.to_i + self.appointment_set.to_i + self.call_back_for_appointment.to_i + self.call_back_for_contacts.to_i + self.call_back_for_decision.to_i + self.call_back_in_a_year.to_i + self.called_no_appointment_set.to_i + self.contact_cards.to_i + self.maintainance.to_i + self.maintainance_done.to_i + self.new_ministry_partner.to_i + self.not_back_until.to_i + self.office_phone_only.to_i + self.on_list.to_i + self.research.to_i + self.would_have_met.to_i
  end

  def contact_total
		self.contact_cards.to_i + self.not_back_until.to_i + self.office_phone_only.to_i + self.research.to_i
	end

	def call_back_total
		self.call_back_for_appointment.to_i + self.call_back_for_decision.to_i	+ self.call_back_for_contacts.to_i
	end

	def appointment_total
		self.appointment_set.to_i + self.called_no_appointment_set.to_i + self.appointment_no_support.to_i + self.new_ministry_partner.to_i
	end

	def future_total
		self.call_back_in_a_year.to_i + self.would_have_met.to_i + self.on_list.to_i
	end

	def mpm_total
		self.maintainance	+ self.maintainance_done.to_i
	end

	def used_contacts_total
		self.call_back_for_decision.to_i + self.call_back_for_contacts.to_i + self.appointment_set.to_i + self.called_no_appointment_set.to_i + self.appointment_no_support.to_i + self.new_ministry_partner.to_i
	end

	def created_at_print
  	self.created_at.strftime('%a, %d %b %y')
  end
end
