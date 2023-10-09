.set noreorder
main: addi $t0, $t0, 1
      addi $t1, $t1, 2
      or $t4, $t1, $t0
      and $t5, $t1, $t0
      ori $t6, $t1, 1
      andi $t7, $t1, 1
      .word 0xfeedfeed
