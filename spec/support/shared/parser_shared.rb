require 'faker'

RSpec.shared_examples 'protocol_parser' do
  let(:data) { packet }
  let(:something) { Faker::Hacker.say_something_smart }
  let(:parser) { described_class.new }

  describe '#get_packet' do
    subject { parser.get_packet(data) }

    context 'received exactly one packet' do
      it 'returns packet and empty string' do
        expect(subject[0]).to eq(data)
        expect(subject[1]).to eq('')
      end
    end

    context 'received two or more packets' do
      let(:data) { packet * 2 }
      it 'returns packet and rest' do
        expect(subject[0]).to eq(packet)
        expect(subject[1]).to eq(packet)
      end
    end

    context 'received one packet and something else' do
      let(:data) { packet + something }
      it 'returns packet and something else' do
        expect(subject[0]).to eq(packet)
        expect(subject[1]).to eq(something)
      end
    end

    context 'received part of valid packet' do
      let(:data) { packet[0..(packet.size / 2)] }
      it 'returns FIN and rest' do
        expect(subject[0]).to eq('FIN')
        expect(subject[1]).to eq(data)
      end
    end

    context 'received broken packet' do
      let(:data) { broken }
      it 'return ERR and rest' do
        expect(subject[0]).to eq('ERR')
        expect(subject[1]).to eq('')
      end
    end
  end

  describe '#parse_packet' do
    subject { parser.parse_packet(packet) }

    it 'returns parsed collection and responce string' do
      expect(subject[0]).to be_kind_of(Enumerable)
      expect(subject[1]).to be_kind_of(String)
    end
  end
end
