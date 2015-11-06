module Bomb
  module SimpleWires
    class FourWireSolver < Solver
      private

      def wire_to_cut
        if more_than_one('red') && Bomb.odd_serial_number?
          'last red'
        elsif last_is('yellow') && has_no('red')
          'first'
        elsif exactly_one 'blue'
          'first'
        elsif more_than_one 'yellow'
          'last'
        else
          'second'
        end
      end
    end
  end
end
