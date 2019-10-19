/***********************************************************************
* File       : <wraparound.c>
*
* Author     : <M.R. Siavash Katebzadeh>
*
* Description:
*
* Date       : 08/10/19
*
***********************************************************************/
// ==========================================================================
// 2D String Finder
// ==========================================================================
// Finds the matching words from dictionary in the 2D grid, including wrap-around

// Inf2C-CS Coursework 1. Task 6
// PROVIDED file, to be used as a skeleton.

// Instructor: Boris Grot
// TA: Siavash Katebzadeh
// 08 Oct 2019

#include <stdio.h>

// maximum size of each dimension
#define MAX_DIM_SIZE 32
// maximum number of words in dictionary file
#define MAX_DICTIONARY_WORDS 1000
// maximum size of each word in the dictionary
#define MAX_WORD_SIZE 10

int read_char() { return getchar(); }
int read_int()
{
  int i;
  scanf("%i", &i);
  return i;
}
void read_string(char* s, int size) { fgets(s, size, stdin); }
void print_char(int c)     { putchar(c); }
void print_int(int i)      { printf("%i", i); }
void print_string(char* s) { printf("%s", s); }
void output(char *string)  { print_string(string); }

// dictionary file name
const char dictionary_file_name[] = "dictionary.txt";
// grid file name
const char grid_file_name[] = "2dgrid.txt";
// content of grid file
char grid[(MAX_DIM_SIZE + 1 /* for \n */ ) * MAX_DIM_SIZE + 1 /* for \0 */ ];
// content of dictionary file
char dictionary[MAX_DICTIONARY_WORDS * (MAX_WORD_SIZE + 1 /* for \n */ ) + 1 /* for \0 */ ];
///////////////////////////////////////////////////////////////////////////////
/////////////// Do not modify anything above
///////////////Put your global variables/functions here///////////////////////

// starting index of each word in the dictionary
int dictionary_idx[MAX_DICTIONARY_WORDS];
// number of words in the dictionary
int dict_num_words = 0;
int no_of_rows = 0;
int no_of_chars_per_row = 0;
int found = 0;

//---------------------------------------------------------------------------
// PRINT_WORD function
//---------------------------------------------------------------------------

// function to print found word
void print_word(char *word)
{
    while(*word != '\n' && *word != '\0') {
        print_char(*word);
        word++;
    }
}

//---------------------------------------------------------------------------
// PRINT_MATCH function
//---------------------------------------------------------------------------

void print_match(int row, int grid_idx, char orientation, char *word)
{
    print_int(row);
    print_char(',');
    print_int(grid_idx);
    print_char(' ');
    print_char(orientation);
    print_char(' ');
    print_word(word);
    print_char('\n');
}

//---------------------------------------------------------------------------
// D_CONTAIN function
//---------------------------------------------------------------------------

// function to see if the diagonal string contains the (\n terminated) word
int d_contain(char *string, char *word, int row, int grid_idx)
{
    while (1)
    {
        // wrap around
        if (row >= no_of_rows || grid_idx >= no_of_chars_per_row - 1)
        {
            while (row > 0 && grid_idx > 0) {
                string -= no_of_chars_per_row + 1;
                row--;
                grid_idx--;
            }
        }

        if (*string != *word)
        {
            break;
        }

        string += no_of_chars_per_row + 1;
        row++;
        word++;
        grid_idx++;
    }

    return (*word == '\n');
    // There are two cases for returns:
    // 1. string and word differ by a char on the last row of the grid or before
    // 2. string and word match for the entire column
    //      1. Either word == '\n' and so returns true
    //      2. The word isn't finished in which case word != '\n'
}

//---------------------------------------------------------------------------
// V_CONTAIN function
//---------------------------------------------------------------------------

// function to see if the vertical string contains the (\n terminated) word
int v_contain(char *string, char *word, int row)
{
    while (1) {
        if (row >= no_of_rows) {
            string -= (no_of_chars_per_row ) * (no_of_rows);
            row = 0;
        }

        if (*string != *word){
            return (*word == '\n');
        }

        string += no_of_chars_per_row;
        row++;
        word++;
    }

    return 0;
    // There are two cases for returns:
    // 1. string and word differ by a char on the last row of the grid or before
    // 2. string and word match for the entire column
    //      1. Either word == '\n' and so returns true
    //      2. The word isn't finished in which case word != '\n'
}

//---------------------------------------------------------------------------
// H_CONTAIN function
//---------------------------------------------------------------------------

// function to see if the horitzontal string contains the (\n terminated) word
int h_contain(char *string, char *word)
{
    while (1) {
        if (*string == '\n')
        {
            string -= (no_of_chars_per_row - 1);
        }
        // *string will never equal '\n' here so when *word == '\n' then
        // *string and *word are guaranteed to be different
        if (*string != *word)
        {
            return (*word == '\n');
        }

        string++;
        word++;
    }

    return 0;
}

//---------------------------------------------------------------------------
// STRFIND function
//---------------------------------------------------------------------------

// Finds all dictionary words in the specified row of the grid
void strfind(int row)
{
    int grid_idx = 0;
    int idx = 0;
    char *word;
    char *grid_position;
    // Every row is the same length, so we can use the first row
    while (grid[grid_idx] != '\n') {
        // for every char in grid, go through all words in dictionary
        for(idx = 0; idx < dict_num_words; idx ++) {
            word = dictionary + dictionary_idx[idx];
            grid_position = grid + row*(no_of_chars_per_row) + grid_idx;
            if (h_contain(grid_position, word)) {
                found = 1;
                print_match(row, grid_idx, 'H', word);
            }

            if (v_contain(grid_position, word, row)) {
                found = 1;
                print_match(row, grid_idx, 'V', word);
            }

            if (d_contain(grid_position, word, row, grid_idx)) {
                found = 1;
                print_match(row, grid_idx, 'D', word);
            }
        }

        grid_idx++;
    }
}

//---------------------------------------------------------------------------
// FIND_NO_OF_ROWS function
//---------------------------------------------------------------------------

// Counts the number of characters in the first line of the grid
int find_no_of_rows()
{
    int i = 0;
    int rows = 0;
    while(grid[i++] != '\0') {
        if (grid[i] == '\n') {
            rows++;
        }
    }
    return rows;
}

//---------------------------------------------------------------------------
// FIND_NO_OF_CHARS_PER_ROW function
//---------------------------------------------------------------------------

// Counts the number of characters in the first line of the grid starting from
// 1 and including the newline character.
// This means adding i to the base address of the grid will return the first
// element of the following row.
int find_no_of_chars_per_row()
{
    int i = 0;
    while(grid[i++] != '\n');
    return i;
}

//---------------------------------------------------------------------------
// MAIN function
//---------------------------------------------------------------------------

int main (void)
{

  /////////////Reading dictionary and grid files//////////////
  ///////////////Please DO NOT touch this part/////////////////
  int c_input;
  int idx = 0;


  // open grid file
  FILE *grid_file = fopen(grid_file_name, "r");
  // open dictionary file
  FILE *dictionary_file = fopen(dictionary_file_name, "r");

  // if opening the grid file failed
  if(grid_file == NULL){
    print_string("Error in opening grid file.\n");
    return -1;
  }

  // if opening the dictionary file failed
  if(dictionary_file == NULL){
    print_string("Error in opening dictionary file.\n");
    return -1;
  }
  // reading the grid file
  do {
    c_input = fgetc(grid_file);
    // indicates the the of file
    if(feof(grid_file)) {
      grid[idx] = '\0';
      break;
    }
    grid[idx] = c_input;
    idx += 1;

  } while (1);

  // closing the grid file
  fclose(grid_file);
  idx = 0;

  // reading the dictionary file
  do {
    c_input = fgetc(dictionary_file);
    // indicates the end of file
    if(feof(dictionary_file)) {
      dictionary[idx] = '\0';
      break;
    }
    dictionary[idx] = c_input;
    idx += 1;
  } while (1);


  // closing the dictionary file
  fclose(dictionary_file);
  //////////////////////////End of reading////////////////////////
  ///////////////You can add your code here!//////////////////////

  int dict_idx = 0;
  int start_idx = 0;

  // storing the starting index of each word in the dictionary
  idx = 0;
  do {
      c_input = dictionary[idx];
      if(c_input == '\0') {
          break;
      }
      if(c_input == '\n') {
          dictionary_idx[dict_idx ++] = start_idx;
          start_idx = idx + 1;
      }
      idx += 1;
  } while (1);

  dict_num_words = dict_idx;

  no_of_rows = find_no_of_rows();
  no_of_chars_per_row = find_no_of_chars_per_row();

  for (int i = 0; i < no_of_rows; i++) {
    strfind(i);
  }

  if (!found) {
      print_string("-1\n");
  }

  return 0;
}
