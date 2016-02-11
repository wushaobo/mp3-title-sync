
if ARGV.length != 1 and ARGV.length != 2
	puts "Usage: rename.rb MP3_DIR_PATH [FILE_NAME_PATTERN]"
	exit(-1)
end

files = Dir[File.join(ARGV[0], '**/*.mp3')]
if files.length == 0
	puts "No mp3 file found in #{ARGV[0]} ."
	exit(0)
end

pattern = ARGV.length == 2 ? Regexp.new(ARGV[0]) : /^.+_(\d\d)_.+\.mp3$/

files.each do |mp3_file|
	base_dir, file_name = File.split(mp3_file)

	if (res = pattern.match(file_name))
		new_name = "#{res[1]}.mp3"
		puts "modify: #{file_name} ==> #{new_name}"
		File.rename(mp3_file, File.join(base_dir, new_name))
	else
		puts "not modified: #{file_name}" 
	end
end
puts "Done! Renamed all #{files.length} mp3 files in #{ARGV[0]} ."