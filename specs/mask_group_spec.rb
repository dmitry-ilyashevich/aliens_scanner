require_relative '../lib/mask_group'

describe MaskGroup do
  let(:masks) { [ double(width: 4, mask: 0b0101), double(width: 4, mask: 0b1010) ] }
  subject { described_class.new(masks) }

  describe "#window_at" do
    it { expect(subject.window_at(0, 0, 2, 2)).to eq(0b0110) }
    it { expect(subject.window_at(0, 0, 4, 2)).to eq(0b01011010) }
    it { expect(subject.window_at(1, 1, 2, 1)).to eq(0b01) }

    it { expect(subject.window_at(-1, 0, 2, 2)).to eq(0) }
    it { expect(subject.window_at(0, 0, 4, 4)).to eq(0) }
    it { expect(subject.window_at(4, 4, 4, 4)).to eq(0) }
    it { expect(subject.window_at(4, 4, 0, 4)).to eq(0) }
  end
end