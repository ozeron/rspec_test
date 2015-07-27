require_relative 'generic'
require 'environment'

module Utility
  module Logger
    class Factory < Generic
      class << self
        def get_logger(name, path=nil)
          return instantiate("#{@default}::#{name}") if path.nil?
          @default = name
          create_default_logger(path)
        end

        private

        def instantiate(name='main')
          return Log4r::Logger[name] unless Log4r::Logger[name].nil?
          Log4r::Logger.new(name)
        end

        def create_default_logger(path)
          logger = Log4r::Logger.new(@default)
          return logger unless logging?
          outputters = [
            fatal_stdout_outputter,
            error_file_outputter(path),
            info_file_outputter(path)
          ]
          outputters << debug_stdout_outputter if Environment::development?
          outputters << debug_file_outputter(path)
          logger.outputters = outputters
          logger
        end

        def fatal_stdout_outputter
          return Log4r::Outputter['fail_stdout'] unless Log4r::Outputter['fail_stdout'].nil?
          o = Log4r::StdoutOutputter.new('fail_stdout')
          o.level = Log4r::FATAL
          o.formatter = formatter
          o
        end

        def debug_stdout_outputter
          return Log4r::Outputter['console'] unless Log4r::Outputter['console'].nil?
          o = Log4r::StdoutOutputter.new('console')
          o.only_at(Log4r::DEBUG)
          o.formatter = formatter
          o
        end

        def error_file_outputter(path)
          path = path.sub(/\.log/, '_error.log')
          o = file_outputter('file_error',path)
          o.level = Log4r::ERROR
          o
        end

        def info_file_outputter(path)
          path = path.sub(/\.log/, '_info.log')
          o = file_outputter('file_info',path)
          o.only_at(Log4r::INFO)
          o
        end

        def debug_file_outputter(path)
          #return Log4r::Outputter unless Environment::development?
          path = path.sub(/\.log/, '_debug.log')
          o = file_outputter('file_debug',path)
          o.only_at(Log4r::DEBUG)
          o
        end

        def file_outputter(name,path)
          return Log4r::Outputter[name] unless Log4r::Outputter[name].nil?
          o = Log4r::FileOutputter.new(name, filename: path)
          o.formatter = formatter
          o
        end

        def formatter
          Log4r::PatternFormatter.new(pattern: " %d [%l %c] :: %m")
        end
      end
    end
  end
end
