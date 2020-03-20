require_relative '../lib/mask_parser'

describe MaskParser do
  let(:input_value) { "oo--\n--oo\n\n" }
  let(:mask) { described_class.new(input_value) }

  describe "sizing of mask" do
    it { expect(mask.width).to eq(4) }
    it { expect(mask.height).to eq(2) }
  end

  describe "mask" do
    it { expect(described_class.new("oooooo-----").mask).to eq(0b11111100000) }
    it { expect(described_class.new("o").mask).to eq(1) }
    it { expect(described_class.new("piu").mask).to eq(0) }
    it { expect(described_class.new("").mask).to eq(0) }
    it { expect(described_class.new(nil).mask).to eq(0) }
    it { expect(described_class.new("yyn", "ny").mask).to eq(0b110) }
  end

  describe "mask_bits_size" do
    it { expect(described_class.new("oooooo-----").mask_bits_size).to eq(11) }
    it { expect(described_class.new("o").mask_bits_size).to eq(1) }
    it { expect(described_class.new("piu").mask_bits_size).to eq(0) }
    it { expect(described_class.new("").mask_bits_size).to eq(0) }
    it { expect(described_class.new(nil).mask_bits_size).to eq(0) }
    it { expect(described_class.new("yyn", "yn").mask_bits_size).to eq(3) }
  end

  describe "#to_s" do
    it { expect(mask.to_s).to eq(input_value) }
  end
end