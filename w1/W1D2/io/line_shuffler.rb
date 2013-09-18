
def line_shuffler
  puts "Please enter a filename"
  filename = gets.chomp

  lines_array = File.readlines(filename)
  lines_array.shuffle!

  output_filename = filename.gsub('.','-shuffled.')

  File.open(output_filename, 'w') do |outfile|
      lines_array.each do |line|
        outfile.
        puts line
      end
  end
end