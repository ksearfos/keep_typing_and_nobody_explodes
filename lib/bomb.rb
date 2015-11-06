require 'require_all'
require_rel 'bomb'

module Bomb
  class UnknownModuleError < StandardError; end

  class << self
    attr_accessor :serial_number

    def odd_serial_number?
      last_digit_of_serial_number.odd?
    end

    def last_digit_of_serial_number
      @last_digit ||= begin
        @serial_number[/(\d)\D*$/]
        Regexp.last_match(1)
      end
    end
  end
end
