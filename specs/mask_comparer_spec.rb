require_relative '../lib/mask_comparer'

describe MaskComparer do
  describe "#similar?" do
    context "acceptable noise ratio 0.3" do
      subject { described_class.new(4, 0b0000, 0.3) }

      it { expect(subject.similar?(0b0000)).to be_truthy }
      it { expect(subject.similar?(0b0001)).to be_truthy }
      it { expect(subject.similar?(0b0100)).to be_truthy }
      it { expect(subject.similar?(0b0101)).to be_falsey }
      it { expect(subject.similar?(0b0111)).to be_falsey }
    end

    context "acceptable noise ratio 0.5" do
      subject { described_class.new(4, 0b0000, 0.5) }

      it { expect(subject.similar?(0b0000)).to be_truthy }
      it { expect(subject.similar?(0b0001)).to be_truthy }
      it { expect(subject.similar?(0b0100)).to be_truthy }
      it { expect(subject.similar?(0b0101)).to be_truthy }
      it { expect(subject.similar?(0b0111)).to be_falsey }
    end
  end
end