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
Provided in the sheet.
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
2,11 H thing
3,8 H area

# Case 2
Provided in the sheet.
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
2,11 H thing
3,8 H area

# Case 3
Quick test to make sure that horizontal matching still works
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
thisenotljnginthis
havedoneppahreason
lessetssarythinear
firstsfdareasbenot
## Expected Output
0,0 H this
0,5 H not
0,5 V not
0,14 H this
1,0 H have
1,12 H reason
2,0 H less
2,15 H ear
3,0 H first
3,8 H area
3,15 H not

# Case 4
Make sure it prints -1 if there are no matches
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
howdoyoudothateveryday
ireallyreallydontknows
youabcdefghijklmnopqrs
## Expected Output
-1

# Case 5
Make sure a grid with 1 row still works when there are no matches
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
howdoyoudothateveryday
## Expected Output
-1

# Case 6
Make sure a grid with 1 row still works when there are matches
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
nothingisimpossiblekids
## Expected Output
0,0 H not
0,0 H nothing
0,2 H thing

# Case 7
Make sure a grid with 1 row still works when vertical matches
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
e
## 2D Grid
everythingisimpossiblekids
## Expected Output
0,0 H e
0,0 V e
0,2 H e
0,2 V e
0,5 H thing
0,21 H e
0,21 V e

# Case 8
Make sure program supports 10 character long words horizontally
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
seasonings
## 2D Grid
seasonings
seasonings
## Expected Output
0,0 H seasonings
0,1 H seasonings

# Case 9
Make sure program supports 10 character long words vertically
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
seasonings
## 2D Grid
seasonings
eabcdefghi
aabcdefghi
sabcdefghi
oabcdefghi
nabcdefghi
iabcdefghi
nabcdefghi
gabcdefghi
sabcdefghi
## Expected Output
0,0 H seasonings
0,0 V seasonings

# Case 10
Make sure program doesn't do any strange vertical wrap arounds
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
seasonings
## 2D Grid
snsnnings
egegefghi
asasefghi
sasdefghi
oaodefghi
nandefghi
iaidefghi
## Expected Output
-1

# Case 11
Make sure program matches words that don't start at the first row or column correctly.
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
seasonings
## 2D Grid
aaaaaaaaaaa
aseasonings
aeabcdefghi
aaabcdefghi
asabcdefghi
aoabcdefghi
anabcdefghi
aiabcdefghi
anabcdefghi
agabcdefghi
asabcdefghi
## Expected Output
1,1 H seasonings
1,1 V seasonings
