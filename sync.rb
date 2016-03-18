require "mp3info"

# Read and display infos & tags

if ARGV.length != 1
	puts "Require 1 argument as the path of directory which contains input mp3 files, but given #{ARGV.length} !"
	exit(-1)
end

files = Dir.glob(File.join(ARGV[0], '**/*.mp3'), File::FNM_CASEFOLD)
if files.length == 0
	puts "No mp3 file found in #{ARGV[0]} ."
	exit(0)
end

files.each do |mp3_file|
	file_name = File.basename(mp3_file)

	Mp3Info.open(mp3_file) do |mp3|
		if mp3.tag.title == file_name
			puts "not modified: #{mp3_file}"
		else 
			puts "modify #{mp3_file}: #{mp3.tag.title} ==> #{file_name}"
			mp3.tag.title = file_name
		end
	end
end
puts "Done! Synchronized title with file name for all #{files.length} mp3 files in #{ARGV[0]} ."