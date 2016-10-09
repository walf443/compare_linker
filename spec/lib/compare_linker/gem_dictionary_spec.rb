require "spec_helper"

describe CompareLinker::GemDictionary do
  describe "#lookup" do
    context 'given a gem name included in the dictionary' do
      subject { described_class.new.lookup('serverspec') }
      it { is_expected.to eq %w(mizzy serverspec) }
    end

    context 'given a gem name not included in the dictionary' do
      subject { described_class.new.lookup('not_exist') }
      it { is_expected.to eq [nil, nil] }
    end
  end
end
