#!/usr/bin/ruby
module Ad_Hoc ; end

require 'optparse'
require 'pp'
require 'fileutils'
### require 'ostruct'
require 'exif'
require 'time'
require 'mini_exiftool'

class Ad_Hoc::Cmd_Opt_Parser

  attr_reader :file_path_list
  attr_reader :output_directory

  CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
  CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

  def initialize(args)
    @file_path_list = []
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
      opts.separator ""
      opts.separator "Options:"
      opts.on("-s SOURCE_PATH", "--source_path SOURCE_PATH", String, "Source path") do |source_path|
        real_source_path = File.realpath(source_path)
        if File.file? real_source_path
          @file_path_list << real_source_path
        elsif File.directory? real_source_path
          @file_path_list = Dir.glob(real_source_path + '/*.*').sort
        end
      end
      opts.on("-o DIRECTORY", "--output DIRECTORY", String, "Output directory") do |output_directory|
        @output_directory = File.realpath(output_directory)
      end
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    opt_parser.parse!(args)
  end

end

class Ad_Hoc::Log

  def event(event_data)
    puts Time.now.to_s + ' - ' + event_data
  end

end

options = Ad_Hoc::Cmd_Opt_Parser.new(ARGV)

options.file_path_list.each do |file_path|
  if File.file? file_path
    data = MiniExiftool.new(file_path)
    pp data
    if data[:date_time_original] || data[:modifydate]
      if data[:date_time_original]
        image_timestamp = data[:date_time_original]
      elsif data[:modifydate]
        image_timestamp = data[:modifydate]
      end
      file_name_index_component = 1
      file_written = false
      while file_written == false
        file_extension = File.extname(file_path).downcase
        file_name_index_component_padded = "%.3i" %file_name_index_component
        file_name = image_timestamp.strftime("%Y%m%d_%H%M%S-" + file_name_index_component_padded + file_extension)
        file_output_path = options.output_directory + '/' + file_name
        if (file_output_path == file_path)
          Ad_Hoc::Log.new.event 'Skipping file: ' + file_path
          file_written = true
        else
          if ! File.exists? file_name
            Ad_Hoc::Log.new.event 'Moving file: ' + file_path + ' to ' + file_output_path
            FileUtils.mv(file_path, file_output_path)
            file_written = true
          else
            file_name_index_component += 1
          end
        end
      end
    end
  end
end
