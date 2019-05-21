
Loop: sll $t1,$s3,2
Add $t1,$t1,$s6
Lw $t0,22($t1)
Bne $t0,$s5,Exit
Addi $s3,$s3,1
J Loop
Exit:
