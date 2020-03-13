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

def ignore_exception
  begin
    yield
  rescue Exception
  end
end

options = Ad_Hoc::Cmd_Opt_Parser.new(ARGV)

options.file_path_list.each do |file_path|
  if File.file? file_path
    save_file = false
    data = MiniExiftool.new(file_path)
    file_name = File.basename(file_path)
    file_name_timestamp = file_name.split('-')[0]
    file_name_index = file_name.split('-')[1]
    file_name_description = file_name.split('-', 3)[2].to_s.split('.')[0].to_s.strip!
    if file_name_timestamp =~ /^\d{8}\_\d{6}$/ && file_name_index =~ /^\d{3}$/
      exif_timestamp = Time.strptime(file_name_timestamp, "%Y%m%d_%H%M%S")
      if ! data[:date_time_original] || exif_timestamp != data[:date_time_original]
        p file_path + ' - ' + exif_timestamp.to_s
        data.date_time_original = exif_timestamp
        save_file = true
      end
      if file_name_description =~ /^[a-zA-Z0-9]{2}.*$/
        if ! data[:image_description] || file_name_description != data[:image_description]
          p file_path + ' - ' + file_name_description
          data.image_description = file_name_description
          save_file = true
        end
      end
    end
    if save_file == true
      data.save
    end
  end
end
