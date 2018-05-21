# converts original mechon mamre htm files of the talmud bavli to txt
# caution: appends to output files, manually erase old ones before running.
require 'nokogiri'
require 'fileutils'
require 'pry'
require 'gematria'

def read_htm(f_name)
  puts 'parsing: ' + f_name
  htm = File.read(f_name)
  Nokogiri.HTML(htm, nil, 'windows-1255')
end

def mkdirs(d_name)
  FileUtils.mkdir(d_name) unless File.directory?(d_name)
end

def book(htm)
  @book_title = htm.css('title')[0].text
  puts 'creating book: ' + @book_title.reverse
  @txt_dir = 'txts/' + @book_title + '/'
  mkdirs(@txt_dir)
  @clean_txt_dir = 'clean_txts/' + @book_title + '/'
  mkdirs(@clean_txt_dir)
  mkdirs('torah_or/' + @book_title)
end

def fix_name(old_name)
  old_name = old_name.split(',')
  daf = Gematria::Calculator.new(old_name[0], :hebrew)
  daf = pad_zero(daf.converted.to_s)
  amud = Gematria::Calculator.new(old_name[1], :hebrew)
  amud = amud.converted.to_s
  daf + '.' + amud
end

def append_file(f_name, f_text)
  puts 'appending to ' + f_name
  f = File.open(f_name, 'a')
  f.write(f_text + "\n")
  f.close
end

def pad_zero(f_name)
  f_name.r_just(3, '0')
end

def sections(section, new_name, section_name)
  amud_text = "\n" + section_name + ': '
  amud_text += section.next.text.sub('  ', '')
  append_file(@txt_dir + new_name, amud_text)
end

def torah_or(amud_text, f_name)
  verses = amud_text.split(/\(|\)/).select.with_index { |_, i| i.odd? }
  verses.each do |verse|
    # write to torah_or/!"
    append_file('torah_or/' + @book_title + '/' + f_name, verse)
    # write to toldos_aharon.csv!
    append_file('toldos_aharon.csv', verse + "\t" + @book_title + "\t" + f_name)
  end
end

def clean_amud_text(amud_text)
  amud_text = amud_text.split(/\(|\)/).select.with_index { |_, i| i.even? }.join
  amud_text = amud_text.split(/\{|\}/).select.with_index { |_, i| i.even? }.join
  amud_text.tr('<>', '()').gsub('  ', ' ')
end

def clean_section_name(section_name)
  if section_name == ' משנה'
    then "מתני'"
  elsif section_name == ' גמרא'
    then "גמ'"
  end
end

def clean_sections(section, new_name, section_name)
  section_name = clean_section_name(section_name)
  amud_text = section_name == @section_name ? '' : ' ' + section_name
  @section_name = section_name
  amud_text += section.next.text
  torah_or(amud_text, new_name)
  amud_text = clean_amud_text(amud_text)
  # write to clean_txts/!
  append_file(@clean_txt_dir + new_name, amud_text.strip)
end

@f_names = Dir['./htm/*.htm']

@f_names[2..-1].each do |f_name|
  htm = read_htm(f_name)
  book(htm)
  htm.css('b').each do |section|
    b_text = section.text.split(' ')
    new_name = fix_name(b_text[1])
    # write to txts/!
    sections(section, new_name, b_text[2])
    # write to clean_txts/ and torah_or/!
    clean_sections(section, new_name, b_text[2])
  end
end
