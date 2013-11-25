class AddDefaultValueToContactCardBoxes < ActiveRecord::Migration
  def change
		change_column :contact_card_boxes, :contact_cards, :integer, :default => 0
		change_column :contact_card_boxes, :not_back_until, :integer, :default => 0
		change_column :contact_card_boxes, :office_phone_only, :integer, :default => 0
		change_column :contact_card_boxes, :research, :integer, :default => 0
		change_column :contact_card_boxes, :call_back_for_appointment, :integer, :default => 0
		change_column :contact_card_boxes, :call_back_for_decision, :integer, :default => 0
		change_column :contact_card_boxes, :call_back_for_contacts, :integer, :default => 0
		change_column :contact_card_boxes, :appointment_set, :integer, :default => 0
		change_column :contact_card_boxes, :called_no_appointment_set, :integer, :default => 0
		change_column :contact_card_boxes, :appointment_no_support, :integer, :default => 0
		change_column :contact_card_boxes, :new_ministry_partner, :integer, :default => 0
		change_column :contact_card_boxes, :call_back_in_a_year, :integer, :default => 0
		change_column :contact_card_boxes, :would_have_met, :integer, :default => 0
		change_column :contact_card_boxes, :on_list, :integer, :default => 0
		change_column :contact_card_boxes, :maintainance, :integer, :default => 0
		change_column :contact_card_boxes, :maintainance_done, :integer, :default => 0
  end
end
