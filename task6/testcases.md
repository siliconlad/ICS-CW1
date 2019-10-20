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
tahoenotljnginvhis
soatdoneppahapaeci
vevtetssarythingha
jpennsfdareasbetaa
## Expected Output
0,2 V have
0,4 V eden
0,5 H not
0,5 V not
1,7 D ear
2,11 H thing
2,16 H have
2,16 D have
3,3 V not
3,8 H area

# Case 2
The diagram in the sheet.
## Dictionary
jinxed
climax
artful
ego
puzzlers
## 2D Grid
jesilnaopo
infmekliel
nnaauktttg
xonxohaiml
enartfullo
dbueddicoo
ersoapuzzl
lsdvmykeee
reacolmaln
ysclasryeo
## Expected Output
0,0 V jinxed
1,8 D ego
4,2 H artful
6,5 H puzzlers
8,3 V climax

# Case 3
Make sure the horizontal matching still works
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
areaaaahappenaaaahave
aaaanothingaaaaaaaaaa
earaaaaaaaaaaaareason
## Expected Output
0,0 H area
0,2 V ear
0,7 H happen
0,17 H have
0,20 H ear
1,2 V area
1,4 H not
1,4 H nothing
1,6 H thing
2,0 H ear
2,14 H area
2,15 H reason

# Case 4
Make sure the vertical matching still works
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
aaaaaaf
raanaai
eaaoaar
aaataas
aaaaaat
## Expected Output
0,0 V area
0,6 V first
1,3 V not
2,5 H area

# Case 5
Make sure the diagonal matching still works
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
aaaaaaaaaaaaanaaaaaaaa
araaaaaaaaaaaaoaaaaaaa
naeaaaaaaaaaaaataaaaaa
aoaaaaaaaaaaaaaahaaaaa
aataaaaaaaaaaaaaaiaaaa
aaaaaaaaaaaaaaaaaanaaa
aaaaaaaaaaaaaaaaaaagaa
## Expected Output
0,0 D area
0,13 D not
0,13 D nothing
2,0 D not
2,15 D thing

# Case 6
Make sure horizontal wrap arounds work in a 1 row grid
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
easonaaaaaaaanaaaaaaar
## Expected Output
0,20 H area
0,21 H reason

# Case 7
Make sure vertical wrap arounds work in a 1 column grid
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
e
a
s
o
n
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
a
r
## Expected Output
29,0 V area
30,0 V reason

# Case 8
Make sure diagonal wrap arounds work in a square grid
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
gaaaaaaoaa
asaaaaaata
aasaaaaaan
aaaeaaaaaa
aaaaaaaaaa
taaaasaaaa
afaaaaoaaa
aaiaaaanaa
aaaraaaaia
aaaasaaaan
## Expected Output
2,2 D seasonings
2,9 D not
6,1 D first

# Case 9
Double check horizontal matches still work
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
gaaaafirst
earaaaaata
## Expected Output
0,5 H first
1,0 H ear

# Case 10
Double check vertical matches still work
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
a
r
e
a
a
a
a
a
a
a
n
o
t
h
i
n
g
## Expected Output
0,0 V area
10,0 V not
10,0 V nothing
12,0 V thing

# Case 11
Check that program works correctly when no matches are found
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
a
## Expected Output
0,0 V area
10,0 V not
10,0 V nothing
12,0 V thing

# Case 11
Check that program works correctly
## Dictionary
a
aa
## 2D Grid
a
## Expected Output
0,0 H a
0,0 V a
0,0 D a
0,0 H aa
0,0 V aa
0,0 D aa
