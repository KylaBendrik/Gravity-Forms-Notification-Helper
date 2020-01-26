# frozen_string_literal: true

require 'yaml'

def save(file_name, info)
  file_path = "./input/#{file_name}"
  today = Time.new

  data = {
    saved_at: today,
    fields: info
  }

  File.open file_path, 'w' do |f|
    f.write data.to_yaml
  end
end

def new_entry(all_info)
  puts 'Please enter the Field Label'
  label = gets.chomp
  puts 'Please enter the Field ID #'
  id = gets.chomp
  puts 'If you want a custom Display Label, enter here. Otherwise, just leave blank'
  display = gets.chomp
  puts "Label:         #{label}"
  puts "ID:            #{id}"
  puts "Display Label: #{display}" unless display.empty?
  puts '---- Is this correct? (y or n)'
  case gets.chomp.downcase
  when 'y'
    all_info.push(
      label: label,
      id: id,
      display: display
    )
  when 'n'
    puts "We'll start this entry again."
    new_entry(all_info)
  end
  puts '-' * 30
  puts 'new entry? (y or n)'
  case gets.chomp.downcase
  when 'y'
    new_entry(all_info)
  when 'n'
    puts "sorry, we can't save anything yet. This feature is coming soon!"
    save($file_name, all_info)
  end
end

puts 'Welcome to the Data Entry program'
puts 'What is the name of this form notification?'
$file_name = gets.chomp
puts 'Gravity forms has two main bits of info we need to make this work nicely:'
puts ' - Field Label'
puts ' - Field ID'
puts "For each item you want in your notification email, you'll need to supply these two things."
puts '-' * 30
puts "Let's begin!"
all_info = []
new_entry(all_info)
