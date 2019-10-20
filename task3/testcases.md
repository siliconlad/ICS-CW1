# Specifications for Input
Your programs for all tasks will be tested against dictionary and grid files that adhere to the following rules.

## Dictionary
* Maximum: **1000 words**
* Max word length: **10 characters**
* All characters are lowercase alphabetic characters (**a-z**)

## Grid
* Maximum grid size: **31x31**
* Grid coordinates start at 0
* All characters are lowercase alphabetic characters (**a-z**)

# Specifications of Output
The outputs of your program must follow the following set of rules:
* Each line of the output containing a matching word should consist of coordinates of the first matching character in the grid delimited by a comma character (‘,’) followed by a space character (‘ ’) followed by one letter indicating the direction (‘H') followed by a space character (‘ ’) followed by a word. Example: 0,12 H joke
* Matches may be printed in any order
* Each line of the output should contain only one match
* If no matches are found, output one line with -1

# Case 1
Included in the sheet.
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
tahbenotljnginthis
soaodoneppahapacci
uevtetssarythingha
jpeansfdareasbetak
## Expected Output
0,5 H not
0,14 H this
2,11 H thing
3,8 H area

# Case 2
Make sure program works for a 1d grid
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
tahbenotljnginthis
## Expected Output
0,5 H not
0,14 H this

# Case 3
Check program detects words in the beginning and end of rows correctly
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
notbendtljngintnot
notodoneppahapanot
nottetssarythinnot
notansfdarewsbenot
## Expected Output
0,0 H not
0,15 H not
1,0 H not
1,15 H not
2,0 H not
2,15 H not
3,0 H not
3,15 H not

# Case 4
Check program doesn't wrap words
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
hingbendtljngintnot
hingadoneppahaphing
## Expected Output
0,16 H not

# Case 5
Check program correctly outputs -1 when not matches are found
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
hingbendtljngintnat
hingadoneppahaphing
## Expected Output
-1

# Case 6
Check program supports 31 characters in a row
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
abcdefghijklmnopqrstuvwxyzabnot
## Expected Output
0,28 H not

# Case 7
Check program supports 31 rows in a grid
## Dictionary
area
eden
this
happen
less
not
have
first
nothing
thing
ear
reason
## 2D Grid
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
abcdefghijklmnopqrstuvwxyzabnot
## Expected Output
0,28 H not
1,28 H not
2,28 H not
3,28 H not
4,28 H not
5,28 H not
6,28 H not
7,28 H not
8,28 H not
9,28 H not
10,28 H not
11,28 H not
12,28 H not
13,28 H not
14,28 H not
15,28 H not
16,28 H not
17,28 H not
18,28 H not
19,28 H not
20,28 H not
21,28 H not
22,28 H not
23,28 H not
24,28 H not
25,28 H not
26,28 H not
27,28 H not
28,28 H not
29,28 H not
30,28 H not
