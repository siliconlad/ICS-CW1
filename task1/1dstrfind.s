
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
newline:                .asciiz     "\n"
end_of_string:          .asciiz     "\0"

#-------------------------------------------------------------------------
# Global variables in memory
#-------------------------------------------------------------------------
#
grid:                   .space 33       # Maximun size of 1D grid_file + NULL
.align 4                                # The next field will be aligned
dictionary:             .space 11001    # Maximum number of words in dictionary *
                                        # ( maximum size of each word + \n) + NULL
# You can add your data here!

dictionary_idx:         .space 4000
dict_num_words:         .word 0
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
        la      $t0, dictionary_idx     # $t0 = dict_idx = &dictionary_idx;
        la      $t1, dictionary         # $t1 = start_idx = &dictionary;
        la      $t2, dictionary         # $t2 = idx = &dictionary;

loop:                                   # $t3 = c_input
        lb      $t3, 0($t2)             # $t3 = dictionary[0]
        lw      $t4, end_of_string

        beq     $t3, $t4, loop_end      # if(c_input == '\0') {break;}

        lw      $t4, newline
        bne     $t3, $t4, inc           # if(c_input != '\n')
        sb      $t1, 0($t0)             # dictionary[dict_idx] = start_idx;
        addi    $t0, $t0, 1             # dict_idx++;
        addi    $t1, $t2, 1             # start_idx = idx + 1;

inc:    addi    $t2, $t2, 1             # idx += 1;
        j       loop


loop_end:
        la      $t5, dict_num_words
        sw      $t0, 0($t5)  #dict_num_words = dict_idx;
        jal     strfind                 # strfind();
        j main_end                      # return 0;


# You can add your code here!

#------------------------------------------------------------------
# print_word(char *word)
#------------------------------------------------------------------
                                            # $a1 = word
print_word:
        lb      $t0, 0($a1)                 # $t0 = *word

        sne     $t1, $t0, newline           # $t1 = *word != '\n'
        sne     $t2, $t0, end_of_string     # $t2 = *word != '\0'
        and     $t3, $t1, $t2               # *word != '\n' && *word != '\0'

        beq     $t3, $0, print_word_rtn     # if ($t3 == 0) {goto print_word_rtn}

        addi    $a0, $t0, $0
        li      $v0, 11
        syscall                             # print_char(*word)

        addi    $a1, 1                      # word++
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
        seq     $v0, $t1, newline           #   return (word == '\n')
        jr      $ra                         # }


contain_inc:
        addi    $t0, $t0, 1                 # string++
        addi    $t1, $t1, 1                 # word ++
                                            #
        j       contain                # while(1)

#------------------------------------------------------------------
# Exit, DO NOT MODIFY THIS BLOCK
#------------------------------------------------------------------
main_end:
        li   $v0, 10          # exit()
        syscall

#----------------------------------------------------------------
# END OF CODE
#----------------------------------------------------------------
