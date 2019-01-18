nasm -f elf *.asm; ld -m elf_i386 -s -o demo *.o
./demo
