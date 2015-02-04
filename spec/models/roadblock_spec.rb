require 'rails_helper'

describe Roadblock do
  it { is_expected.to have_db_column :title }
  it { is_expected.to have_db_column :message }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :message }
end
