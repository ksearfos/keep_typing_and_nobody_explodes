require_relative 'simple_wires/solver'
require_rel 'simple_wires'

module KeepTypingAndNobodyExplodes
  module SimpleWires
    class << self
      def solve!(*colors)
        solver(colors.size).go! colors
      end

      private

      def solver(size)
        case size
        when 3 then ThreeWireSolver
        when 4 then FourWireSolver
        when 5 then FiveWireSolver
        when 6 then SixWireSolver
        else raise UnknownModuleError "#{size} simple wires"
        end
      end
    end
  end
end
