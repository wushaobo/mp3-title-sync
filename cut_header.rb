
if ARGV.length != 3
	puts "Usage: ruby cut_header.rb INPUT_DIR OUTPUT_DIR START_OFFSET"
	puts "	Example: ruby cut_header.rb /tmp/input /tmp/output 00:01:23.45"
	exit(-1)
end

input_dir = ARGV[0]
output_dir = ARGV[1]
start_offset = ARGV[2]

def collect_input_files(input_dir)
	files = Dir.glob(File.join(input_dir, '**/*.mp3'), File::FNM_CASEFOLD)
	if files.length == 0
		puts "No mp3 file found in #{input_dir} ."
		exit(0)
	end
	files
end

def cut_header_for(files, output_dir, offset)
	files.each do |file|
		base_dir, file_name = File.split(file)
		if file_name.start_with? '1'
			`cp -f #{file} #{output_dir}/#{file_name[1..-1]}`
		else
			`ffmpeg -ss #{offset} -i #{file} -acodec copy -y #{output_dir}/#{file_name}`
		end
	end
end

input_files = collect_input_files(input_dir)
cut_header_for(input_files, output_dir, start_offset)

puts "Done! Cut header for all #{input_files.length} mp3 files in #{input_dir} ."