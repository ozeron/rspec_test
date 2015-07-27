require 'eventmachine'

TEST_PORT = 59_687

RSpec.shared_examples 'protocol_server' do
  # define let(:server) in block when calling from rspec
  # define let(:messages) to specify expected responces from server
  # define let(:responces) to specify responces from server
  # define let(:onclose) and let(:onmessage) callback to test responces from server

  let(:client) { FakeSocketClient.new(messages); }

  before do
    client.onmessage = onmessage
    client.onclose = onclose
  end

  describe 'server send right responce to initial message' do
    EM.run {
      EM.start_server 'localhost', TEST_PORT, server

    }
  end


end
