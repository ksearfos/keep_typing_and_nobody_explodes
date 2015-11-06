require 'spec_helper'

RSpec.describe Bomb::SimpleWires::ThreeWireSolver, simple_wires: true do
  describe '.go!' do
    context 'when there are no red wires' do
      let(:wires)  { %w(blue yellow white) }
      let(:target) { 'second' }

      include_context 'solves_simple_wires_correctly'
    end

    context 'when there is at least one red wire' do
      context 'when the last wire is white' do
        let(:wires)  { %w(red yellow white) }
        let(:target) { 'last' }

        include_context 'solves_simple_wires_correctly'
      end

      context 'when the last wire is not white' do
        context 'when there is more than one blue wire' do
          let(:wires)  { %w(red blue blue) }
          let(:target) { 'last blue' }

          include_context 'solves_simple_wires_correctly'
        end

        context 'when there is at most one blue wire' do
          let(:wires)  { %w(red blue black) }
          let(:target) { 'last' }

          include_context 'solves_simple_wires_correctly'
        end
      end
    end
  end
end
