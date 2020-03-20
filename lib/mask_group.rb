class MaskGroup
  attr_reader :width, :height

  def initialize(masks)
    @masks = masks

    @width = @masks.first.width
    @height = @masks.size
  end

  def window_at(x, y, window_width, window_height)
    return 0 if x < 0
    return 0 if y < 0
    return 0 if x + window_width > width
    return 0 if y + window_height > height

    h = 0

    window = 0
    while h < window_height
      rshift = width - x - window_width
      lshift = (window_width * window_height) - (h + 1) * window_width
      window |= ((@masks[y + h].mask >> rshift) & (2**window_width - 1)) << lshift
      h += 1
    end

    window
  end
end