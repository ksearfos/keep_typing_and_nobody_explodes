require 'spec_helper'

RSpec.describe Bomb::SimpleWires::FourWireSolver, simple_wires: true do
  describe '.go!' do
    context 'when there is more than one red wire and the bomb has an odd serial number' do
      let(:wires)  { %w(red red red red) }
      let(:target) { 'last red' }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      include_context 'solves_simple_wires_correctly'
    end

    context 'when there is at most one red wire (but an odd serial number)' do
      let(:wires) { %w(white white white white) }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the last red wire.\n").to_stdout
      end
    end

    context 'when the bomb has an even serial number (but multiple red wires)' do
      let(:wires)  { %w(red red red red) }

      before { allow(Bomb).to receive(:odd_serial_number?) { false } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the last red wire.\n").to_stdout
      end
    end

    context 'when there is at most one red wire or the bomb has an even serial number' do
      context 'when the last wire is yellow and there are no red wires' do
        let(:wires)  { %w(white white blue yellow) }
        let(:target) { 'first' }

        include_context 'solves_simple_wires_correctly'
      end

      context 'when the last wire is not yellow or there are red wires' do
        context 'when there is a single blue wire' do
          let(:wires)  { %w(red white blue black) }
          let(:target) { 'first' }

          include_context 'solves_simple_wires_correctly'
        end

        context 'when there are no blue wires, or are multiple blue wires' do
          context 'and the last wire is not yellow (but there is one red wire)' do
            let(:wires) { %w(yellow white white black) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the first wire.\n").to_stdout
            end
          end

          context 'and there is one red wire (but the last wire is yellow)' do
            let(:wires) { %w(red blue blue yellow) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the first wire.\n").to_stdout
            end
          end

          context 'when there is more than one yellow wire' do
            let(:wires)  { %w(yellow yellow yellow red) }
            let(:target) { 'last' }

            include_context 'solves_simple_wires_correctly'
          end

          context 'when there is at most one yellow wire' do
            let(:wires)  { %w(red yellow blue blue) }
            let(:target) { 'second' }

            include_context 'solves_simple_wires_correctly'
          end
        end
      end
    end
  end
end
