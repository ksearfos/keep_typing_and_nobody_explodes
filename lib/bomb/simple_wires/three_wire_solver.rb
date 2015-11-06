module Bomb
  module SimpleWires
    class ThreeWireSolver < Solver
      private

      def wire_to_cut
        if has_no 'red'
          'second'
        elsif last_is 'white'
          'last'
        elsif more_than_one 'blue'
          'last blue'
        else
          'last'
        end
      end
    end
  end
end
