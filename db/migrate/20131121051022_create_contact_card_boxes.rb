class CreateContactCardBoxes < ActiveRecord::Migration
  def change
    create_table :contact_card_boxes do |t|
      t.integer :week_id
      t.integer :contact_cards
      t.integer :not_back_until
      t.integer :office_phone_only
      t.integer :research
      t.integer :call_back_for_appointment
      t.integer :call_back_for_decision
      t.integer :call_back_for_contacts
      t.integer :appointment_set
      t.integer :called_no_appointment_set
      t.integer :appointment_no_support
      t.integer :new_ministry_partner
      t.integer :call_back_in_a_year
      t.integer :would_have_met
      t.integer :on_list
      t.integer :maintainance
      t.integer :maintainance_done
      t.integer :user_id

      t.timestamps
    end
  end
end
