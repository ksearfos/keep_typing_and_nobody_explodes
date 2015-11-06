module Bomb
  module SimpleWires
    class FiveWireSolver < Solver
      private

      def wire_to_cut
        if last_is('black') && Bomb.odd_serial_number?
          'fourth'
        elsif exactly_one('red') && more_than_one('yellow')
          'first'
        elsif has_no 'black'
          'second'
        else
          'first'
        end
      end
    end
  end
end
