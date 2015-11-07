require 'spec_helper'

RSpec.describe Bomb::SimpleWires::FiveWireSolver, simple_wires: true do
  describe '.go!' do
    context 'when the last wire is black and the bomb has an odd serial number' do
      let(:wires)  { %w(red red red red black) }
      let(:target) { 'fourth' }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      include_context 'solves_simple_wires_correctly'
    end

    context 'when the last wire is not black (but there is an odd serial number)' do
      let(:wires) { %w(white white white white blue) }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the fourth wire.\n").to_stdout
      end
    end

    context 'when the bomb has an even serial number (but the last wire is black)' do
      let(:wires)  { %w(red red red red black) }

      before { allow(Bomb).to receive(:odd_serial_number?) { false } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the fourth wire.\n").to_stdout
      end
    end

    context 'when the last wire is not black or the bomb has an even serial number' do
      context 'when there is a single red wire and multiple yellow wires' do
        let(:wires)  { %w(red white yellow yellow white) }
        let(:target) { 'first' }

        include_context 'solves_simple_wires_correctly'
      end

      context 'when there is not exactly one red wire or there is at most one yellow wire' do
        context 'when there are no black wires' do
          let(:wires)  { %w(red red red red yellow) }
          let(:target) { 'second' }

          include_context 'solves_simple_wires_correctly'

          context 'and there is not exactly one red wire (but there are multiple yellow wires)' do
            let(:wires) { %w(yellow yellow red red red) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the first wire.\n").to_stdout
            end
          end

          context 'and there is at most one yellow wire (but there is exactly one red)' do
            let(:wires) { %w(red blue blue white yellow) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the first wire.\n").to_stdout
            end
          end
        end

        context 'when there is at least one black wire' do
          let(:wires)  { %w(red red red black red) }
          let(:target) { 'first' }

          include_context 'solves_simple_wires_correctly'
        end
      end
    end
  end
end
