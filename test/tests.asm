# Test almost every possible instruction and return true if passed
.set noreorder
main: li    $t0, 1              # Loading in constants for testing
      li    $t1, 2
      li    $t2, 3
      li    $t3, 4
      li    $s0, 0              # Test results stored in $s0.  Should be 0 at end of program
      add   $t5, $t0, $t1       # $t4 - $t8 used as transfer registers for tests
      sub   $s0, $t5, $t2       # $s0 = 3 - 3
      and   $t5, $t5, $t0       # 3 & 1 = 1
      andi  $t6, $t5, 2         # 1 & 2 = 0
      add   $s0, $s0, $t6       # $s0 = $s0 + 0
      or    $t5, $t0, $t1       # 1 | 2 = 3
      ori   $t6, $t1, 1         # 2 | 1 = 3
      nor   $s0, $t5, $t6       # ~(3 | 3) = 0
      slt   $t5, $t0, $t1       # 0 < 1 (True)
      slti  $t6, $t2, 5         # 3 < 5 (True)
      srl   $t6, $t6, 1         # 1 >> 1 = 0
      sll   $t5, $t5, 1         # 1 << 1 = 2
      slt   $s0, $t5, $t6       # 2 < 0 (False)
      blez  $s0, hop            # 0 <= 0 (True)
      addi  $s0, $s0, 10        # $s0 = $s0 + 10, should be skipped by BLEZ
hop:  bgtz  $t5, skip           # 2 > 0 (True)
      nop
      addi  $s0, $s0, 5         # $s0 = $s0 + 5, should be skipped by BGTZ
skip: j     jump                # Jump to address 104
      nop
      addi  $s0, $s0, 7         # $s0 = $s0 +7, should be skipped by jump
jump: beq   $s0, $t6, trip      # 0 = 0 (True)
      nop
      addi  $s0, $s0, 9         # $s0 = $s0 + 9, should be skipped by BEQ
trip: bne   $t5, $t6, fall      # 2 != 0 (True) 
      nop
      addi  $s0, $s0, 8         # $s0 = $s0 + 8, should be skipped by BNE
fall: la    $t7, 208            # $t7 = address of A[]
      sw    $t3, 0($t7)         # A[0] = 4
      lw    $t5, 0($t7)         # $t5 = A[0]
      li    $t6, 257            # $t6 = 257
      sb    $t6, 4($t7)         # A[1] = 1
      lbu   $t6, 4($t7)         # $t6 = A[1]
      sh    $t5, 8($t7)         # A[2] = 4
      lhu   $t4, 8($t7)         # $t6 = A[3]
      sub   $s0, $t5, $t4       # $s0 = 3 - 3
      lui   $t5, 12             # $t5 = (upper immediate of) 12 
      slti  $s0, $t5, 10        # 12 < 10 (False)
      la    $t8, 188            # Load jump address into register
      jr    $t8                 # Jump to addres 188
      nop
      add   $s0, $s0, $t8       # $s0 = $s0 + 188, should be skipped by JR
      jal   end                 # Jump to end and link, ra should contain 0x000000c4
      nop
      add   $s0, $s0, $t8       # $s0 = $s0 + 188, should be skipped by JAL
end:  add   $v0, $s0, $s0       # $v0 = $s0 (should be 0)
      .word 0xfeedfeed
      .word 0x0                 # size of "array"
      .word 0x0                 # size of "array"
      .word 0x0                 # size of "array"
      .word 0xc                 # size of "array"



