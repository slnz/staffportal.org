module Dmpd
  class LogDecorator < ApplicationDecorator
    def contact_ratio
      received_contacts.to_d / used_contacts.to_d
    end

    def range
      "#{start} - #{finish}"
    end
  end
end
