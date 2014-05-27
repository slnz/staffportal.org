class XpLevel < ActiveRecord::Base
  # attr_accessible :next_id, :xp_min, :xp_max, :name
  belongs_to :next, class_name: 'XpLevel', foreign_key: 'next_id'
end
