


.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
.end_macro

