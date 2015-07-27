require 'eventmachine'
# Class wich provide simple messaging interface
# to test work of server
class FakeSocketClient < EM::Connection
  attr_writer :onclose, :onmessage
  attr_reader :data, :state, :messages


  # @param [Array<String>] messages to be sent on server
  # @return [FakeSocketClient] object of FakeSocketClient
  def initialize(messages)
    @data = []
    @messages = messages
  end

  # Send init message to the server
  def post_init
    send_next_message
    close_connection_if_no_messages
  end

  def receive_data(data)
    @data << data
    onmessage.call(data) if onmessage
    send_next_message
    close_connection_if_no_messages
  end

  def send_next_message
    send_data(messages.shift) unless messages.empty?
  end

  def close_connection_if_no_messages
    close_connection_after_writing if messages.empty?
  end

  def unbind
    onclose.call if onclose
  end
end
