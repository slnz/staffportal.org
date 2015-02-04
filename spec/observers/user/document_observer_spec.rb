require 'rails_helper'
vcr_options = { cassette_name: 'user/document_observer' }
RSpec.describe User::DocumentObserver, type: :observer, vcr: vcr_options do
  describe '#before_create' do
    subject { described_class.instance }
    it do
      is_expected.to receive(:before_create)
      User::Document.observers.enable described_class do
        create(:document)
      end
    end
  end
  describe '#after_create' do
    subject { described_class.instance }
    it do
      is_expected.to receive(:after_create)
      User::Document.observers.enable described_class do
        create(:document)
      end
    end
  end
end
