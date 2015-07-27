module Logger
  # Class for making dump of incomming packets splitted by imei
  class Imei
    attr_reader :file

    def initialize(path)
      FileUtils::mkdir_p(path)
      path = File.join(path, Time.now.utc.strftime('%Y_%m_%d.bin'))
      @file = File.open(path, 'ab')
    end

    def info(string)
      file.write(string)
      file.flush
    end

    def close
      file.close
    end
  end
end
