class MaskParser
  attr_reader :value, :width, :height

  # chars should be a possible ascii symbols in mask input
  def initialize(value, chars = '-o')
    value = value.to_s
    @width = value.split("\n").first.to_s.size
    @height = value.split("\n").size

    @chars = chars.chars
    @original_value = value
    @value = value.to_s.gsub(Regexp.new("[^#{@chars.join('')}]"), '').chars
  end

  def mask
    @mask ||= value.inject(0) do |res, char|
      res <<= 1
      res |= 1 if char == @chars.last
      res
    end
  end

  def mask_bits_size
    value.size
  end

  def to_s
    @original_value
  end
end
