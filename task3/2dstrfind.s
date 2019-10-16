
#=========================================================================
# 2D String Finder
#=========================================================================
# Finds the [first] matching words from dictionary in the grid
#
# Inf2C Computer Systems
#
# Siavash Katebzadeh
# 8 Oct 2019
#
#
#=========================================================================
# DATA SEGMENT
#=========================================================================
.data
#-------------------------------------------------------------------------
# Constant strings
#-------------------------------------------------------------------------

grid_file_name:         .asciiz  "2dgrid.txt"
dictionary_file_name:   .asciiz  "dictionary.txt"
newline:                .asciiz  "\n"

#-------------------------------------------------------------------------
# Global variables in memory
#-------------------------------------------------------------------------
#
grid:                   .space 1057     # Maximun size of 2D grid_file + NULL (((32 + 1) * 32) + 1)
.align 4                                # The next field will be aligned
dictionary:             .space 11001    # Maximum number of words in dictionary *
                                        # ( maximum size of each word + \n) + NULL
# You can add your data here!
.align 2
dictionary_idx:         .space 4000
dict_num_words:         .word 0
end_of_string:          .asciiz     "\0"
no_finds:               .asciiz     "-1\n"
no_of_rows:             .space 4
no_of_chars_per_row:    .space 4
found:                  .space 4
#=========================================================================
# TEXT SEGMENT
#=========================================================================
.text

#-------------------------------------------------------------------------
# MAIN code block
#-------------------------------------------------------------------------

.globl main                     # Declare main label to be globally visible.
                                # Needed for correct operation with MARS
main:
#-------------------------------------------------------------------------
# Reading file block. DO NOT MODIFY THIS BLOCK
#-------------------------------------------------------------------------

# opening file for reading

        li   $v0, 13                    # system call for open file
        la   $a0, grid_file_name        # grid file name
        li   $a1, 0                     # flag for reading
        li   $a2, 0                     # mode is ignored
        syscall                         # open a file

        move $s0, $v0                   # save the file descriptor

        # reading from file just opened

        move $t0, $0                    # idx = 0

READ_LOOP:                              # do {
        li   $v0, 14                    # system call for reading from file
        move $a0, $s0                   # file descriptor
                                        # grid[idx] = c_input
        la   $a1, grid($t0)             # address of buffer from which to read
        li   $a2,  1                    # read 1 char
        syscall                         # c_input = fgetc(grid_file);
        blez $v0, END_LOOP              # if(feof(grid_file)) { break }
        addi $t0, $t0, 1                # idx += 1
        j    READ_LOOP
END_LOOP:
        sb   $0,  grid($t0)            # grid[idx] = '\0'

        # Close the file

        li   $v0, 16                    # system call for close file
        move $a0, $s0                   # file descriptor to close
        syscall                         # fclose(grid_file)


        # opening file for reading

        li   $v0, 13                    # system call for open file
        la   $a0, dictionary_file_name  # input file name
        li   $a1, 0                     # flag for reading
        li   $a2, 0                     # mode is ignored
        syscall                         # fopen(dictionary_file, "r")

        move $s0, $v0                   # save the file descriptor

        # reading from  file just opened

        move $t0, $0                    # idx = 0

READ_LOOP2:                             # do {
        li   $v0, 14                    # system call for reading from file
        move $a0, $s0                   # file descriptor
                                        # dictionary[idx] = c_input
        la   $a1, dictionary($t0)       # address of buffer from which to read
        li   $a2,  1                    # read 1 char
        syscall                         # c_input = fgetc(dictionary_file);
        blez $v0, END_LOOP2             # if(feof(dictionary_file)) { break }
        lb   $t1, dictionary($t0)
        beq  $t1, $0,  END_LOOP2        # if(c_input == '\0')
        addi $t0, $t0, 1                # idx += 1
        j    READ_LOOP2
END_LOOP2:
        sb   $0,  dictionary($t0)       # dictionary[idx] = '\0'

        # Close the file

        li   $v0, 16                    # system call for close file
        move $a0, $s0                   # file descriptor to close
        syscall                         # fclose(dictionary_file)
#------------------------------------------------------------------
# End of reading file block.
#------------------------------------------------------------------

# You can add your code here!
        la      $s0, dictionary_idx     # &dictionary_idx[dict_idx];
        la      $s1, dictionary         # &dictionary[idx];
        li      $s2, 0                  # idx = 0
        li      $s3, 0                  # dict_idx = 0
        li      $s4, 0                  # start_idx = 0

loop:
        lb      $t1, 0($s1)             # c_input = dictionary[idx]
        li      $t2, 0                  # $t2 = "\0"

        beq     $t1, $t2, loop_end      # if(c_input == '\0') {break;}

        li      $t2, 10                 # $t2 = '\n'
        bne     $t1, $t2, inc           # if(c_input != '\n')
        sb      $s4, 0($s0)             # dictionary_idx[dict_idx] = start_idx;
        addi    $s0, $s0, 4             # &dictionary_idx[dict_idx++] (int so ++ by 4 bytes)
        addi    $s3, $s3, 1             # dict_idx++;

        addi    $s4, $s2, 1             # start_idx = idx + 1;

inc:
        addi    $s2, $s2, 1             # idx++;
        addi    $s1, $s1, 1             # &dictionary[idx++]
        j       loop


loop_end:
        la      $t5, dict_num_words
        sw      $s3, 0($t5)             # dict_num_words = dict_idx;

        jal     find_no_of_rows         # find_no_of_rows();
        la      $t1, no_of_rows
        sw      $v0, 0($t1)             # no_of_rows = find_no_of_rows();

        jal     find_no_of_chars_per_row(); # find_no_of_chars_per_row();
        la      $t1, no_of_chars_per_row
        sw      $v0, 0($t1)             # no_of_chars_per_row = find_no_of_chars_per_row();

        # The reason $s6 is used is because strfind uses registers $s0-s5 and $s7.
        li      $s6, 0                  # i = 0;
main_for_loop:
        la      $t0, no_of_rows         # $t0 = &no_of_rows
        lw      $t0, 0($t0)             # $t0 = no_of_rows
        bge     $s6, $t0, main_for_loop_end

        add     $a0, $s6, $zero
        jal     strfind                 # strfind(i);

        addi    $s6, $s6, 1             # i++;
        j       main_for_loop


main_for_loop_end:
        la      $t1, found
        lw      $t2, 0($t1)
        bne     $t2, $zero, main_end    # if(found) {return 0;}

        la      $a0, no_finds           # if(!found) {
        li      $v0, 4                  # print_string("-1\n")
        syscall                         # }

        j       main_end                # return 0;

#------------------------------------------------------------------
# print_word(char *word)
#------------------------------------------------------------------
                                        # $a1 = word
print_word:
        lb      $t0, 0($a1)             # $t0 = *word

        li      $t4, 10                 # $t4 = '\n'
        sne     $t1, $t0, $t4           # $t1 = *word != '\n'
        li      $t4, 0                  # $t4 = '\0'
        sne     $t2, $t0, $t4           # $t2 = *word != '\0'
        and     $t3, $t1, $t2           # *word != '\n' && *word != '\0'

        beq     $t3, $0, print_word_rtn # if ($t3 == 0) {goto print_word_rtn}

        addi    $a0, $t0, 0
        li      $v0, 11
        syscall                         # print_char(*word)

        addi    $a1, $a1, 1                  # word++
        j       print_word

print_word_rtn:
        jr $ra

#------------------------------------------------------------------
# contain(char *string, char *word)
#------------------------------------------------------------------
                                            # $a0 = string
contain:                                    # $a1 = word
        li      $t0, 10                     # $t0 = '\n'
        lb      $t1, 0($a0)                 # $t1 = *string
        lb      $t2, 0($a1)                 # $t2 = *word
        seq     $t3, $t1, $t2               # set $t3=1 if *string == *word
        seq     $t4, $t1, $t0               # set $t4=1 if *string == '\n'
        seq     $t5, $t2, $t0               # set $t5=1 if *word == '\n'
        and     $t4, $t4, $t5               # $t4 = $t4 && $t5
        or      $t3, $t3, $t4               # $t3 = $t3 || $t4

        bne     $t3, $zero, contain_inc
                                            # else{
        seq     $v0, $t1, $t4               #   return (word == '\n')
        jr      $ra                         # }


contain_inc:
        addi    $a0, $a0, 1                 # string++
        addi    $a1, $a1, 1                 # word++
        j       contain                     # while(1)

#------------------------------------------------------------------
# strfind(int row);
#------------------------------------------------------------------

strfind:                                    # $a0 = row
        la      $s0, dictionary_idx         # &dictionary_idx[idx];
        la      $s1, grid                   # &grid[grid_idx];
        li      $s2, 0                      # word = 0;
        la      $s3, dictionary             # $s3 = dictionary
        li      $s4, 0                      # idx
        li      $s5, 0                      # grid_idx

str_while_loop:
        lb      $t1, 0($s1)                 # $t1 = grid[grid_idx]
        li      $t4, 10                      # $t4 = '\n'
        beq     $t1, $t4, strfind_return    # if(grid[grid_idx] == '\n') togo strfind_return

        # Reset idx to 0
        li      $s4, 0                      # idx = 0
        la      $s0, dictionary_idx         # &dictionary_idx[idx];

str_for_loop:
        la      $t4, dict_num_words
        lw      $t3, 0($t4)                 # *dict_num_words
        bge     $s4, $t3, str_while_loop_inc# if(idx >= dict_num_words)

        lw      $t2, 0($s0)                 # dictionary_idx[idx];

        add     $s2, $s3, $t2               # word = dictionary + dictionary_idx[idx];

        add     $s7, $ra, $0                # Save $ra

        la      $t0, no_of_chars_per_row    # $t0 = &no_of_chars_per_row
        lw      $t0, 0($t0)                 # $t0 = no_of_chars_per_row
        addi    $t0, $t0, 1                 # $t0 = no_of_chars_per_row + 1
        mul     $t0, $t0, $a0               # $t0 = row * (no_of_chars_per_row + 1)
        add     $t0, $t0, $s1               # $t0 = $t0 + &grid[grid_idx]

        add     $a0, $t0, $0                # $a0 = &grid[grid_idx]
        add     $a1, $s2, $0                # $a1 = word
        jal     contain                     # contain(&grid[grid_idx], word)

        add     $ra, $s7, $0                # Restore original $ra

        beq     $v0, $0, str_for_loop_inc   # if (contain(&grid[grid_idx], word))

        li      $v0, 1                      # $a0 already has the value of row
        syscall                             # print_int(row);

        li      $a0, 44                     # $a0 = ','
        li      $v0, 11                     # print_char(',')
        syscall

        addi    $a0, $s5, $zero             # $a0 = grid_idx
        li      $v0, 1                      #
        syscall                             # print_int(grid_idx)

        li      $a0, 32                     # ' ' = 32 in ascii
        li      $v0, 11                     #
        syscall                             # print_char(' ');

        li      $a0, 72                     # $a0 = 'H'
        li      $v0, 11                     #
        syscall                             # print_char('H');

        li      $a0, 32                     # ' ' = 32 in ascii
        li      $v0, 11                     #
        syscall                             # print_char(' ');

        add     $s7, $ra, $0                # Save $ra
        add     $a1, $s2, $0                #
        jal     print_word                  # print_word(word);
        add     $ra, $s7, $0                # Restore original $ra

        li      $a0, 10                     # $a0 = '\n'
        li      $v0, 11                     #
        syscall                             # print_char('\n');

        la      $t0, found                  #
        li      $t1, 1                      #
        sw      $t1, 0($t0)                 # found = 1;

str_for_loop_inc:
        addi    $s0, $s0, 4                 # &dictionary_idx[idx++] (int so by 4 bytes)
        addi    $s4, $s4, 1                 # idx++
        j       str_for_loop

str_while_loop_inc:
        addi    $s1, $s1, 1                 # &grid[grid_idx++]; (char so by 1 byte)
        addi    $s5, $s5, 1                 # grid_idx++;
        j       str_while_loop

strfind_return:
        jr  $ra                             # return to main

#------------------------------------------------------------------
# find_no_of_rows();
#------------------------------------------------------------------

find_no_of_rows:
        la      $t0, grid                   # char *i = grid;
        li      $t1, 0                      # int rows = 0;
        li      $t2, 10                     # $t2 = '\n'

        lb      $t3, 0($t0)                 # $t3 = grid[i]
        addi    $t0, $t0, 1                 # i++;
        beq     $t3, $zero, find_no_of_rows_end # if(grid[i] == 0){return rows;}

        bne     $t3, $t2, find_no_of_rows   # if(grid[i] != '\n'){jump to find_no_of_rows}
        addi    $t1, $t1, 1                 # rows++;
        j       find_no_of_rows

find_no_of_rows_end:
        add     $v0, $t1, 0
        jr      $ra                         # return rows;

#------------------------------------------------------------------
# find_no_of_chars_per_row();
#------------------------------------------------------------------

find_no_of_chars_per_row:
        li      $t0, 0                      # int i = 0;
        la      $t1, grid
        li      $t2, 10                     # $t2 = '\n'

        lb      $t3, 0($t1)                 # $t3 = grid[i]
        addi    $t0, $t0, 1                 # i++;
        addi    $t1, $t1, 1                 # grid++;

        bne     $t3, $t2, find_no_of_chars_per_row  # loop

        addi    $t0, $t0, -1                # i -= 1
        add     $v0, $t0, $zero             # return i
        jr      $ra

find_no_of_chars_per_row_return:
        addi    $t0, $t0, -1                # i -= 1
        add     $v0, $t0, $zero             # return i
        jr      $ra

#------------------------------------------------------------------
# Exit, DO NOT MODIFY THIS BLOCK
#------------------------------------------------------------------
main_end:
        li   $v0, 10          # exit()
        syscall

#----------------------------------------------------------------
# END OF CODE
#----------------------------------------------------------------
