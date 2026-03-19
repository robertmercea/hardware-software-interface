# Solution for the Ghidra task

- open Ghidra and create a new project
- import the file into the project
- decompile it
- find the `validate` function and see that it returns `secret + 0x539`
- run `old-hits` in `gdb`, run through the code until a value is assigned to `secret`
- see the `secret` value, copy it
- when the program asks for user input, give it `secret + 0x539`
