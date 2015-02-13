module Dmpd
  class Log < ActiveRecord::Base
    default_scope { order('start') }
    self.table_name = 'dmpd_logs'
    belongs_to :user
  end
end
