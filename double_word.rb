# frozen_string_literal: true

# This class describes a signed word of 64 bits (or 8 bytes)
class DoubleWord
  attr_reader :bits

  class << self
    def representable_integer?(number)
      floor = -(2**63)
      ceil = (2**63) - 1

      (floor..ceil).cover?(number)
    end
  end

  def initialize(bits = '0' * 64)
    raise 'invalid bits size' unless bits.size == 64

    @bits = bits
  end

  def bits=(value)
    raise 'invalid bits size' unless value.size == 64

    @bits = value
  end
end
