
if ARGV.length != 2
	puts "Usage: ruby rename.rb MP3_DIR_PATH FILE_NAME_PATTERN"
	puts "	Example: ruby rename.rb /tmp/mp3/ '^.+(\\d\\d).+\.mp3$'"
	puts "	    /tmp/mp3/XXXX1-002XXXX.mp3  ==>  /tmp/mp3/1-002.mp3"
	exit(-1)
end

mp3_dir = ARGV[0]
pattern = ARGV.length == 2 ? Regexp.new(ARGV[1]) : /^.+_(\d\d)_.+\.mp3$/

files = Dir.glob(File.join(mp3_dir, '**/*.mp3'), File::FNM_CASEFOLD)
if files.length == 0
	puts "No mp3 file found in #{mp3_dir} ."
	exit(0)
end

files.each do |file|
	base_dir, file_name = File.split(file)

	if (res = pattern.match(file_name))
		new_name = "#{res[1]}.mp3"
		puts "modify: #{file_name} ==> #{new_name}"
		File.rename(file, File.join(base_dir, new_name))
	else
		puts "not modified: #{file_name}" 
	end
end

puts "Done! Renamed all #{files.length} mp3 files in #{mp3_dir} ."