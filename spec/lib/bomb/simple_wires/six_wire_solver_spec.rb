require 'spec_helper'

RSpec.describe Bomb::SimpleWires::SixWireSolver, simple_wires: true do
  describe '.go!' do
    context 'when there are no yellow wires and the bomb has an odd serial number' do
      let(:wires)  { %w(red red red red red red) }
      let(:target) { 'third' }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      include_context 'solves_simple_wires_correctly'
    end

    context 'when there are yellow wires (but the bomb has an odd serial number)' do
      let(:wires) { %w(yellow yellow yellow yellow yellow yellow) }

      before { allow(Bomb).to receive(:odd_serial_number?) { true } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the third wire.\n").to_stdout
      end
    end

    context 'when the bomb has an even serial number (but there are no yellow wires)' do
      let(:wires)  { %w(red red red red red red) }

      before { allow(Bomb).to receive(:odd_serial_number?) { false } }

      specify do
        expect do
          described_class.go! wires
        end.not_to output("Cut the third wire.\n").to_stdout
      end
    end

    context 'when there is at least one yellow wire or the bomb has an even serial number' do
      context 'when there is exactly one yellow wire and more than one white wire' do
        let(:wires)  { %w(yellow red blue black white white) }
        let(:target) { 'fourth' }

        include_context 'solves_simple_wires_correctly'
      end

      context 'when there are multiple yellow wires or at most one white wire' do
        context 'when there are no red wires' do
          let(:wires)  { %w(yellow yellow yellow yellow blue black) }
          let(:target) { 'last' }

          include_context 'solves_simple_wires_correctly'

          context 'and there is exactly one yellow wire (but at most one white)' do
            let(:wires)  { %w(yellow blue black blue black white) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the fourth wire.\n").to_stdout
            end
          end

          context 'and there is more than one white wire (but there are multiple yellows)' do
            let(:wires)  { %w(yellow white yellow white yellow white) }

            specify do
              expect do
                described_class.go! wires
              end.not_to output("Cut the fourth wire.\n").to_stdout
            end
          end
        end

        context 'when there is at least one red wire' do
          let(:wires)  { %w(yellow red yellow black red white) }
          let(:target) { 'fourth' }

          include_context 'solves_simple_wires_correctly'
        end
      end
    end
  end
end
