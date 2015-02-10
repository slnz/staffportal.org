require 'rails_helper'

describe User do
  subject { create :user }
  it { is_expected.to be_kind_of(RoleModel) }
  it { is_expected.to be_kind_of(Devise::Models::Trackable) }
  it { is_expected.to be_kind_of(Devise::Models::CasAuthenticatable) }
  it { is_expected.to have_many :documents }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to belong_to :ministry }
  it 'has user roles' do
    expect(described_class.valid_roles).to eq([:account_holder,
                                               :contact,
                                               :reviewer,
                                               :statistician,
                                               :trainee,
                                               :player,
                                               :attendee,
                                               :admin,
                                               :trainer,
                                               :hr])
  end
  it 'paginates per 50' do
    expect(described_class.default_per_page).to eq(50)
  end
  context '#cas_extra_attributes=' do
    let(:user) { attributes_for :full_user }
    it 'stores first_name' do
      subject.cas_extra_attributes = { firstName: user[:first_name] }
      expect(subject.first_name).to eq(user[:first_name])
    end
    it 'stores last_name' do
      subject.cas_extra_attributes = { lastName: user[:last_name] }
      expect(subject.last_name).to eq(user[:last_name])
    end
    it 'stores email' do
      subject.cas_extra_attributes = { email: user[:email] }
      expect(subject.email).to eq(user[:email])
    end
  end
  describe '#as' do
    context 'role not set' do
      it 'raises an exception' do
        expect { subject.as :account_holder }.to(
          raise_error CanCan::AccessDenied)
      end
    end
    context 'role set' do
      it 'returns role typed object' do
        subject.roles << :account_holder
        expect(subject.as :account_holder).to be_a(User::AsAccountHolder)
      end
    end
  end
end
