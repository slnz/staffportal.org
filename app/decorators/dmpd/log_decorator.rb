module Dmpd
  class LogDecorator < ApplicationDecorator
    def contact_ratio
      (received_contacts || 0).to_d / (used_contacts || 0).to_d
    end

    def range
      "#{start} - #{finish}"
    end
  end
end
