./vasm/vasm6502_oldstyle -Fbin -dotdir input/blink.s -o output/blink.out

hexdump -C output/blink.out

# Read content on chip and write current content to read.out
minipro/minipro -p AT28C256 -r output/read.out

# Write content in file to chip
minipro/minipro -p AT28C256 -s -u -w /Users/aroelofs/PycharmProjects/6502/output/blink.out

# Program eeprom with half moon towards cable entry/exit