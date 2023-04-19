# frozen_string_literal: true

require './alu'
require './double_word'

# This class describes memory for a risc V emulator
class Memory
  attr_accessor :stack

  def initialize(size)
    raise 'invalid memory size' unless ((2**0)..(2**10)).cover?(size)

    @size = size
    # @stack = size.times.map { DoubleWord.new }
    @stack = size.times.map { nil }
  end

  def load_value(position)
    raise 'invalid position' unless (0..@size).cover?(position)

    @stack[position]
  end

  def store_value(position, value)
    raise 'invalid position' unless (0..@size).cover?(position)

    @stack[position] = value
  end
end
