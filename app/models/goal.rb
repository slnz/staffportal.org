class Goal < ActiveRecord::Base
  belongs_to :account
  belongs_to :type
  # attr_accessible :account_id, :amount, :type_id
  validates_presence_of :account, :type, :amount
end
