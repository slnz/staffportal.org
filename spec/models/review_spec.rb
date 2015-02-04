require 'rails_helper'

describe Review do
  subject { create :review }
  it { is_expected.to have_db_column(:open).of_type(:date) }
  it { is_expected.to have_db_column(:due).of_type(:date) }
  it { is_expected.to validate_presence_of :open }
  it { is_expected.to validate_presence_of :due }
  it 'prevents open date being after due' do
    subject.open = subject.due + 1.day
    is_expected.to_not be_valid
  end
  it 'prevents due date being before open' do
    subject.due = subject.open - 1.day
    is_expected.to_not be_valid
  end
end
