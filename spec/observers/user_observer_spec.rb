require 'rails_helper'
vcr_options = { cassette_name: 'user_observer' }
RSpec.describe UserObserver, type: :observer, vcr: vcr_options do
  describe '#before_validation' do
    subject { described_class.instance }
    it do
      is_expected.to receive(:before_validation)
      User.observers.enable described_class do
        create(:user,
               email: 'bill.bright@cru.org',
               password: 'jesusislord')
      end
    end
    context 'correct credentials' do
      let(:user) do
        build(:user,
              email: 'bill.bright@cru.org',
              password: 'jesusislord')
      end
      it do
        User.observers.enable described_class do
          expect(user).to be_valid
        end
      end
    end
    context 'incorrect credentials' do
      let(:user) do
        build(:user,
              email: 'bill.bright@cru.org',
              password: 'wrongpassword')
      end
      it do
        User.observers.enable described_class do
          expect(user).to_not be_valid
        end
      end
    end
  end
end
