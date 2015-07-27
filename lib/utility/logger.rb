
require 'log4r'
require_relative 'logger/generic'
require_relative 'logger/binary'
require_relative 'logger/factory'
require_relative '../gps_receiver'

module Utility
  module Logger
    module_function

    def supress_logs!
      Generic.supress_logs!
    end

    def bin_logger(name)
      path = File.join(path_to_bin_logs, name)
      @bin_logger ||= Logger::Binary.new(path)
    end

    def logger(name='main', path=nil)
      Logger::Factory.get_logger(name, path)
    end

    def format_bin(packet)
      packet.to_s.unpack('H*').first
    end

    def path_to_log(filename)
      File.join(path_to_logs, filename)
    end

    def default_logs_path
    	File.join(::GpsReceiver::APP_ROOT, 'logs')
    end

    def path_to_bin_logs
      return @path_to_bin_logs unless @path_to_bin_logs.nil?
      @path_to_bin_logs = ENV.fetch('PATH_TO_BIN_LOGS', nil)
      @path_to_bin_logs ||= ENV.fetch('PATH_TO_LOGS', default_logs_path)
      ::FileUtils::mkdir_p(@path_to_bin_logs)
      @path_to_bin_logs
    end

    def path_to_logs
      return @path_to_logs unless @path_to_logs.nil?
      @path_to_logs = ENV.fetch('PATH_TO_LOGS', default_logs_path)
      ::FileUtils::mkdir_p(@path_to_logs)
      @path_to_logs
    end
  end
end
