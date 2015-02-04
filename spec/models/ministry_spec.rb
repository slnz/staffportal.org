require 'rails_helper'

describe Ministry do
  it { is_expected.to have_db_column :name }
  it { is_expected.to validate_presence_of :name }
end
