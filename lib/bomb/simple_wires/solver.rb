module Bomb
  module SimpleWires
    class Solver
      def self.go!(wires)
        new(wires).solve
      end

      def initialize(wires)
        @wires = wires.map(&:to_str).map(&:downcase)
      end

      def solve
        puts "Cut the #{wire_to_cut} wire."
      end

      private

      def wire_to_cut
        fail "Please define #{self.class}#wire_to_cut"
      end

      def more_than_one(color)
        amount_of(color) > 1
      end

      def exactly_one(color)
        amount_of(color) == 1
      end

      def has_no(color)
        !@wires.include?(color)
      end

      def amount_of(color)
        @wires.count { |wire| wire == color }
      end

      def last_is(color)
        @wires.last == color
      end
    end
  end
end
