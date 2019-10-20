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
* Each line of the output containing a matching word should consist of the index of the first matching character in the grid followed by a space character (‘ ’) followed by the word. Example: 12 joke
* Matches may be printed in any order
* Each line of the output should contain only one match
* If no matches are found, output one line with -1

# Case 1
Given in sheet.
## Dictionary
lose
this
just
happen
part
not
have
first
nothing
thing
reason
## 1D Grid
maybenothinginthisworldhappensby
## Expected Output
5 not

# Case 2
Given in sheet.
## Dictionary
lose
this
just
happen
part
not
have
first
nothing
thing
reason
## 1D Grid
foolswhodontorespectthepastareli
## Expected Output
-1

# Case 3
Ensure output is correct when there is an overlapping word (in conjunction with test case 1).
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
maybenothinginthisworldhappensby
## Expected Output
5 Nothing

# Case 4
Ensure output is correct when word is at the beginning
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
thisisjustthebeginningoftheendsh
## Expected Output
0 this

# Case 5
Ensure output is correct when word is at the end
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
foolswhodontorespectthepasreason
## Expected Output
26 reason

# Case 6
Ensure program works with a different length grid
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
hepasreason
## Expected Output
5 reason

# Case 7
Ensure program works with a different length grid
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
thepastisthepast
## Expected Output
-1

# Case 8
Ensure program works when the grid contains only one word
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
part
## Expected Output
0 part

# Case 9
Ensure program works when the word is longer than the grid
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
reason
## 1D Grid
reaso
## Expected Output
-1

# Case 10
Ensure program works with 10 character words
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
seasonings
## 1D Grid
alwaysaddsomeseasonings
## Expected Output
13 seasonings

# Case 11
Ensure program works with 10 character words
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
seasonings
## 1D Grid
abcdefghialwaysaddsomeseasonings
## Expected Output
22 seasonings

# Case 12
Ensure program works with 10 character words
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
seasonings
## 1D Grid
seasoningsabcdefghialwaysaddsome
## Expected Output
0 seasonings

# Case 13
Ensure program works with 1 character grid
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
seasonings
## 1D Grid
s
## Expected Output
-1

# Case 14
Ensure program works with 1 character grid
## Dictionary
lose
this
just
happen
part
nothing
not
have
first
thing
seasonings
s
## 1D Grid
s
## Expected Output
0 s
