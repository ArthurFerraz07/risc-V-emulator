# frozen_string_literal: true

Bundler.require(:default)

require './alu'
require './emulator'

emulator = Emulator.new(10)

emulator.x5 = 5
emulator.x6 = 6

# ap emulator.memory

# emulator.add(:x28, :x5, :x6)
# ap emulator.x28
# emulator.sd(:x28, 0)
# ap emulator.memory
# ap emulator.x28
# emulator.addi(:x28, :x5, 2)
# ap emulator.x28
# ap emulator.memory
# emulator.ld(:x29, 0)
# ap emulator.x28
# ap emulator.x29
# ap emulator.memory


include ALU

dword_a = integer_to_double_word((2**63) - 2)
dword_b = integer_to_double_word(1)

sum = binary_sum(dword_a, dword_b)

ap sum

binding.pry

