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
0,2 V have
0,4 V eden
0,5 H not
0,5 V not
0,14 H this
1,7 D ear
2,11 H thing
3,8 H area

# Case 2
Make sure that diagonals work regardless of position
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
seasoning
## 2D Grid
sahbenntl
seaodonop
ueatetsst
jpesnsfda
fpeaosfda
fieannfda
jiransida
jprsnsfna
jpestsfdg
## Expected Output
0,0 D seasoning
0,4 V eden
0,5 V not
0,6 D not
4,0 D first

# Case 3
Make sure that diagonals work with a 1D grid
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
seasoning
s
## 2D Grid
sahbsnnts
## Expected Output
0,0 H s
0,0 V s
0,0 D s
0,4 H s
0,4 V s
0,4 D s
0,8 H s
0,8 V s
0,8 D s

# Case 4
Make sure that diagonals work with when words don't start or end on the first or last column and row.
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
seasoning
s
## 2D Grid
aaaaaaaaaaaaaaaaaaaaaaa
aaaaanaaaaaaaaaaaaaaaaa
aaaaaaoaaaaaaaaaaaaaaaa
aaaaaaataaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaa
## Expected Output
1,5 D not

# Case 5
Make sure program works when there is only one column
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
seasoning
s
## 2D Grid
a
a
n
o
t
a
a
s
n
o
t
## Expected Output
2,0 V not
7,0 H s
7,0 V s
7,0 D s
8,0 V not

# Case 6
Make sure program works when there is only one column
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
seasoning
s
## 2D Grid
aaaaaaaaaaaaaaaaaaaaaaa
aaaaanaaaaaaaaaaaaaaaaa
aaaaaaoaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaas
## Expected Output
4,22 H s
4,22 V s
4,22 D s

# Case 7
Make sure program works when there are no matches
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
seasoning
s
## 2D Grid
a
## Expected Output
-1
