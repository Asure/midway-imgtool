{
  /* Hide all symbols so SDL2's PLT resolves strcmp/strcpy to libc,
     not to the asm-defined copies in the executable. */
  local: *;
};
