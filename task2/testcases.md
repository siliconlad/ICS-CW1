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
Included in sheet.
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
5 nothing
7 thing
14 this
23 happen

# Case 2
Make sure program works when there is no match
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
Make sure program catches all matches of the same word
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
thisswhodontorespectthethisareli
## Expected Output
0 this
23 this

# Case 4
Make sure program catches words at the beginning and end of the grid
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
thisswhodontorespectthethisapart
## Expected Output
0 this
23 this
28 part

# Case 5
Make sure program works with one word in grid
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
lose
## Expected Output
0 lose

# Case 6
Make sure program searches for words until the end of the dictionary
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
reason
## Expected Output
0 reason

# Case 7
Make sure program works with 10 character words
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
seasonings
## 1D Grid
thisswhoseasoningsctthethisapart
## Expected Output
0 this
8 seasonings
23 this
28 part

# Case 8
Make sure program works with overlapping words
## Dictionary
a
aa
aaa
## 1D Grid
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
## Expected Output
0 a
0 aa
0 aaa
1 a
1 aa
1 aaa
2 a
2 aa
2 aaa
3 a
3 aa
3 aaa
4 a
4 aa
4 aaa
5 a
5 aa
5 aaa
6 a
6 aa
6 aaa
7 a
7 aa
7 aaa
8 a
8 aa
8 aaa
9 a
9 aa
9 aaa
10 a
10 aa
10 aaa
11 a
11 aa
11 aaa
12 a
12 aa
12 aaa
13 a
13 aa
13 aaa
14 a
14 aa
14 aaa
15 a
15 aa
15 aaa
16 a
16 aa
16 aaa
17 a
17 aa
17 aaa
18 a
18 aa
18 aaa
19 a
19 aa
19 aaa
20 a
20 aa
20 aaa
21 a
21 aa
21 aaa
22 a
22 aa
22 aaa
23 a
23 aa
23 aaa
24 a
24 aa
24 aaa
25 a
25 aa
25 aaa
26 a
26 aa
26 aaa
27 a
27 aa
27 aaa
28 a
28 aa
28 aaa
29 a
29 aa
30 a
