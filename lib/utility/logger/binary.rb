require_relative 'generic'

module Utility
  module Logger
    # Class for making dump of incomming packets
    class Binary #< Generic
      attr_reader :path

      def initialize(path)
        FileUtils.mkdir_p(path)
        @path = File.join(path, Time.now.utc.strftime('%Y_%m_%d.bin'))
      end

      def f
        @file ||= File.open(path, 'ab')
      end

      def info(string)
        #  puts logging?
        #  return unless logging?
        byebug
        f.write(string)
        f.flush
      end

      def close
        @file.close unless @file.nil?
        @file = nil
      end
    end
  end
end
