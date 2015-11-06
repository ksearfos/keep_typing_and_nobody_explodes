module Bomb
  module SimpleWires
    class SixWireSolver < Solver
      private

      def wire_to_cut
        if has_no('yellow') && Bomb.odd_serial_number?
          'third'
        elsif exactly_one('yellow') && more_than_one('white')
          'fourth'
        elsif has_no 'red'
          'last'
        else
          'fourth'
        end
      end
    end
  end
end
