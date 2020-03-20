class MaskComparer
  def initialize(mask_bits_size, reference_mask, acceptance_noise_ratio = 0.3)
    @reference_mask = reference_mask
    @mask_bits_size = mask_bits_size.to_f
    @acceptance_noise_ratio = acceptance_noise_ratio
  end

  def similar?(mask)
    difference = mask ^ @reference_mask
    return true if difference == 0

    count_ones(difference) / @mask_bits_size <= @acceptance_noise_ratio
  end

  private

  def count_ones(value)
    ones = 0

    while value > 0
      ones += value & 1

      value >>= 1
    end

    ones
  end
end
