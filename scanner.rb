#! /usr/bin/ruby

require_relative 'lib/mask_comparer'
require_relative 'lib/mask_group'
require_relative 'lib/mask_parser'

TIMOFEI = <<ALIEN_ASCII
--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
ALIEN_ASCII

GRIGORIY = <<ALIEN_ASCII
---oo---
--oooo--
-oooooo-
oo-oo-oo
oooooooo
--o--o--
-o-oo-o-
o-o--o-o
ALIEN_ASCII

class AliensScanner
  def initialize(map, acceptable_noise_ratio = 0.20)
    @radar_mask = MaskGroup.new(map.split("\n").map { |row| MaskParser.new(row) })
    @acceptable_noise_ratio = acceptable_noise_ratio
  end

  def coordinates_of(alien)
    reference_mask = MaskParser.new(alien)
    comparator = MaskComparer.new(reference_mask.mask_bits_size, reference_mask.mask, @acceptable_noise_ratio)
    coordinates = []
    x = 0
    y = 0

    while (y + reference_mask.height) <= @radar_mask.height
      while (x + reference_mask.height) <= @radar_mask.width
        radar_window = @radar_mask.window_at(x, y, reference_mask.width, reference_mask.height)

        if comparator.similar?(radar_window)
          coordinates << [x, y]

          # puts "at [#{x}; #{y}]"
          # radar_window.to_s(2).rjust(reference_mask.mask_bits_size, '0').scan(Regexp.new(".{1,#{reference_mask.width}}", 'm')).each do |line|
          #   puts line.tr('0', '-').tr('1', 'o')
          # end
        end

        x += 1
      end

      x = 0
      y += 1
    end

    coordinates
  end
end

aliens_scanner = AliensScanner.new(ARGF.read)

puts "Possible coordinaties of Grigoriy:"
puts GRIGORIY
puts aliens_scanner.coordinates_of(GRIGORIY).inspect

puts "Possible coordinaties of Timofei:"
puts TIMOFEI
puts aliens_scanner.coordinates_of(TIMOFEI).inspect