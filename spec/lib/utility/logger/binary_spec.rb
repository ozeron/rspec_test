require 'spec_helper'
require 'utility/logger/binary'

describe Utility::Logger::Binary do
  let(:tested_class) { Utility::Logger::Binary }
  let(:path) { 'logfile' }
  let(:fileio) { double('File') }
  let(:path_to_log) { "#{path}/2015_04_13.bin" }

  before do
#    tested_class.enable_logs!
    allow(File).to receive(:open).with(path_to_log, 'ab')
    allow(Time).to receive(:now).and_return( Time.new(2015, 04, 13, 12, 00, 5).utc )
  end

  # after do
  # #  tested_class.supress_logs!
  # end

  let(:logger) { tested_class.new(path) }
  #
  # describe '#new' do
  #   it { expect(tested_class.new(path)).to be_kind_of(tested_class) }
  # end

  describe '#info' do
    let(:str) { 'Hello!' }
    let(:io) { StringIO.new('', 'ab') }

    before do
      allow(logger).to receive(:file) { io }
    end

    it 'open file in path' do
      byebug
      expect(File).to receive(:open).with(path_to_log, 'ab')
      logger.info(str)
    end

    # it 'writes string in byte format' do
    #   logger.info(str)
    #   expect(io.string).to eq(str)
    # end
  end
end
