module Utility
  module Logger
    class Generic
      @@log = true

      def self.supress_logs!
        @@log = false
      end

      def self.enable_logs!
        # IMPORTANT: Attention loggers created with factory when supression will not
        # be recreated!!!
        @@log = true
      end

      def self.logging?
        @@log
      end

      def logging?
        @@log
      end
    end
  end
end
