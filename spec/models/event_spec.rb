require 'rails_helper'

describe Event do
  it { is_expected.to have_many :registrations }
  it { is_expected.to have_many(:users).through(:registrations) }
  it { is_expected.to belong_to :logo }
  it { is_expected.to belong_to :programme }
  it { is_expected.to belong_to :venue }
  it { is_expected.to belong_to :speaker }
  it { is_expected.to belong_to :information }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :finish_date }
  it { is_expected.to validate_presence_of :adult_cost }
  it { is_expected.to validate_presence_of :logo }
  it { is_expected.to validate_presence_of :teen_cost }
  it { is_expected.to validate_presence_of :child_cost }
  context 'dates' do
    subject { create :event }
    it 'prevents start_date date being after finish_date' do
      subject.start_date = subject.finish_date + 1.day
      is_expected.to_not be_valid
    end
    it 'prevents finish_date date being before start_date' do
      subject.finish_date = subject.start_date - 1.day
      is_expected.to_not be_valid
    end
  end
end
