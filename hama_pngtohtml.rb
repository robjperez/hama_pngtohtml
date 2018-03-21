#!/usr/bin/env ruby
require 'RMagick'
require 'yaml'

def search_entry_by_code(palette, hama_code)
  (palette.find do |k, v|
    v['hama_code'] == hama_code
  end).first
end

if ARGV.length > 2 || ARGV.length < 1
  puts "usage: hama_pngtohtml IMAGE.png [PALETTE_ALTERNATIVE.yml]"
  exit -1
end

palette_hama_file = 'palette_hama.yml'
palette_alternative_file = ARGV[1]
image_file = ARGV[0]

unless File.exists?(image_file)
  puts "Cannot open image file"
  exit
end

unless File.exists?(palette_hama_file)
  puts "Cannot open palette_hama.yml"
  exit
end

palette_hama = YAML::load_file(palette_hama_file)
palette_alternative = nil
if !ARGV[1].nil? && File.exists?(palette_alternative_file)
  palette_alternative = YAML::load_file(palette_alternative_file)
end

img = Magick::Image::read(image_file).first.flop
row = 0
puts "<html><body><table><tr>"

img.each_pixel do |pixel, c, r|
  if r != row
    puts "</tr><tr>"
    row = r
  end

  pixel_html_color = pixel.to_color(Magick::AllCompliance, false, 8, true)
  palette_entry = pixel_html_color

  unless palette_alternative.nil?
    palette_entry = search_entry_by_code(palette_hama, palette_alternative[pixel_html_color])
  end

  unless palette_hama[palette_entry].nil?
    style_string = "background-color: #{palette_entry} !important;"
    puts "<td style='#{style_string}'>
      <span style='color: white'>#{palette_hama[palette_entry]["hama_code"]}</span>
    </td>"
  else
    puts "<td>!!!</td>"
  end
end

puts "</tr><table></body></html>"
