
#=========================================================================
# 1D String Finder
#=========================================================================
# Finds the [first] matching word from dictionary in the grid
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

grid_file_name:         .asciiz     "1dgrid.txt"
dictionary_file_name:   .asciiz     "dictionary.txt"
.align 2
newline:                .asciiz     "\n"

#-------------------------------------------------------------------------
# Global variables in memory
#-------------------------------------------------------------------------
#
grid:                   .space 33       # Maximun size of 1D grid_file + NULL
.align 4                                # The next field will be aligned
dictionary:             .space 11001    # Maximum number of words in dictionary *
                                        # ( maximum size of each word + \n) + NULL
# You can add your data here!
.align 2
dictionary_idx:         .space 4000
.align 2
dict_num_words:         .word 0
.align 2
end_of_string:          .asciiz     "\0"
.align 2
no_finds:               .asciiz     "-1\n"
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
        lb   $t1, grid($t0)
        addi $v0, $0, 10                # newline \n
        beq  $t1, $v0, END_LOOP         # if(c_input == '\n')
        addi $t0, $t0, 1                # idx += 1
        j    READ_LOOP
END_LOOP:
        sb   $0,  grid($t0)             # grid[idx] = '\0'

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
        la      $s0, dictionary_idx     # dictionary_idx[dict_idx];
        la      $s1, dictionary         # dictionary[idx];
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
        addi    $s0, $s0, 4             # dictionary_idx[dict_idx]++
        addi    $s3, $s3, 1             # dict_idx++;

        addi    $s4, $s2, 1             # start_idx = idx + 1;

inc:    addi    $s2, $s2, 1             # idx++;
        addi    $s1, $s1, 1             # dictionary[idx]++
        j       loop


loop_end:
        la      $t5, dict_num_words
        sw      $s3, 0($t5)  #dict_num_words = dict_idx;
        jal     strfind                 # strfind();
        j main_end                      # return 0;

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
        lb      $t0, 0($a0)                 # $t0 = *string
        lb      $t1, 0($a1)                 # $t1 = *word
        beq     $t0, $t1, contain_inc       # if (string == word) {jump}
                                            # else{
        li      $t4, 10                     # $t4 = '\n'
        seq     $v0, $t1, $t4               #   return (word == '\n')
        jr      $ra                         # }


contain_inc:
        addi    $a0, $a0, 1                 # string++
        addi    $a1, $a1, 1                 # word++
        j       contain                     # while(1)

#------------------------------------------------------------------
# strfind();
#------------------------------------------------------------------

strfind:
        la      $s0, dictionary_idx         # dictionary_idx[idx];
        la      $s1, grid                   # grid[grid_idx];
        li      $s2, 0                      # word = 0;
        la      $s3, dictionary             # $s3 = dictionary
        li      $s4, 0                      # idx
        li      $s5, 0                      # grid_idx

str_while_loop:
        lb      $t1, 0($s1)                 # $t1 = grid[grid_idx]
        li      $t4, 0                      # $t4 = '\0'
        beq     $t1, $t4, strfind_end       # if(grid[grid_idx] == '\0') togo strfind_end

        # Reset idx to 0
        li      $s4, 0                      # idx = 0
        la      $s0, dictionary_idx         # dictionary_idx[idx];

str_for_loop:
        la      $t4, dict_num_words
        lw      $t3, 0($t4)                 # *dict_num_words
        bge     $s4, $t3, str_while_loop_inc# if(idx >= dict_num_words)

        lw      $t2, 0($s0)                 # dictionary_idx[idx];

        add     $s2, $s3, $t2               # word = dictionary + dictionary_idx[idx];

        add     $s7, $ra, $0                # Save $ra

        add     $a0, $s1, $0                # $a0 = grid + grid_idx
        add     $a1, $s2, $0                # $a1 = word
        jal     contain                     # contain(grid + grid_idx, word)

        add     $ra, $s7, $0                # Restore original $ra

        beq     $v0, $0, str_for_loop_inc   # if (contain(grid+grid_idx, word))

        add     $a0, $s5, $0
        li      $v0, 1
        syscall                             # print_int(grid_idx);

        li      $a0, 32                     # ' ' = 32 in ascii
        li      $v0, 11
        syscall                             # print_char(' ');

        add     $s7, $ra, $0                # Save $ra

        add     $a1, $s2, $0
        jal     print_word                  # print_word(word);

        add     $ra, $s7, $0                # Restore original $ra

        la      $a0, newline
        li      $v0, 11
        syscall                             # print_char('\n');

        jr      $ra                         # return;

str_for_loop_inc:
        addi    $s0, $s0, 4                 # dictionary_idx += 4
        addi    $s4, $s4, 1                 # idx++
        j       str_for_loop

str_while_loop_inc:
        addi    $s1, $s1, 1                 # grid++;
        addi    $s5, $s5, 1                 # grid_idx++;
        j       str_while_loop

strfind_end:
        la      $a0, no_finds
        li      $v0, 4
        syscall                             # print_string("-1\n");
        jr  $ra                             # return to main

#------------------------------------------------------------------
# Exit, DO NOT MODIFY THIS BLOCK
#------------------------------------------------------------------
main_end:
        li   $v0, 10          # exit()
        syscall

#----------------------------------------------------------------
# END OF CODE
#----------------------------------------------------------------
