from sequtils import map, filter
from sugar import `=>`, `->`
from strformat import `&`

#[ Comments
and these are still
comments]#

proc echoo[T](x: T) = stdout.write(x)

echoo "|"
echoo "|"
echo("|")
echo('A')

echoo """
Oh hello there Paul
"""

let purr = () => echoo "purr"
purr()
purr()
echoo "\n"

# Stropping example
var `echo` = "I'm an echo"
echo `echo`

# Add 2 to the integer
proc addTwo(num: int): int =
 num+2

echo "2+2 = ", addTwo(2)

# Define all parameter types in one shot
proc max(a, b, c: int): int =
 if a > b and a > c: a
 else:
  if b > c and b > a: b
  else: c

echo &"max of 1 2 3: {max(1,2,3)}"

# Example: Using default parameter and procedure overloading
proc max(a, b = 0): int =
 max(a, b, 0)

echo &"Using max with just one parameter and second one is default: {max(5)}"

# Example of a function (proc) returning a function (proc).  Notice the amount of type declarations needed
proc aFuncMaxPlus(i:int) : (a:int)->int = 
 (x:int) => max(x)+i
echo "Using a function to create another function and then calling it: ",  aFuncMaxPlus(20)(5)


# Arrays - allocated on the stack.  Static size
# Runtime checks as well as long as --boundsChecks is NOT turned off.
# NOTE THAT -d: release will turn off --boundsChecks
var alist : array[3, int]
alist[0] = 1
alist[2] = 10008
assert alist[2] == 10008
echo "Contents of alist is, ", alist.repr(), " note that the second value is '0'"

# Use an array constructor
var aListAgain = [1,2,3,4,5,100]
for x in aListAgain:
 echoo x
echo "\n"

# Sequences
let aSeq: seq[int] = @[12,334,35,456, 99]
let newSeq : seq[int] = aSeq.map( num =>  num + 1)
echoo &"The new sequence is  {newSeq}"
echo "\n"

# Case statements
proc overUnder100(x:int) = 
 case x
 of 0..99: echoo "The number is less than 100 "
 of 100 : echoo "The number is 100 "
 of 101..high(int) : echoo "The number is greater than 100 "
 else: echoo "Oh no!! "

echo "Your name: "
var name: string = readLine(stdin)

case name:
of "Mae": echo "Hi ", name
of "Paul": echo "Hello, ", name, "!!!"
else: echo "Helloooooo ", name, "!!!!!!!!!!!"

# For loop with iterator
for iter, x in newSeq:
 overUnder100(x)
 echo &"The iterator in the sequence or array: {iter}"

echo "\n"

# User defined object - Nominal Types
type 
 Cords = object
  x: int
  y: int
# Define the object reference
 CordsRef = ref Cords

let b: Cords = Cords(x: 1, y: 2)
echo "b coordinates are: ", b
let c: seq[Cords] = @[b, b, b]
echo "sequence of c is ", c
# sequence of c is @[(x: 1, y: 2), (x: 1, y: 2), (x: 1, y: 2)]

let d = c.map(cord => cord.x+cord.y)
echo "d is ", d

let e = d.filter(x => x > 3)
echo "e is ", e

# Objects are immutable.  This will fail to compile
# proc changeCordsFail(a : Cords) =
#  a.x = 0
#  a.y = 0

# This will work because it's a reference to an object
let f : CordsRef = CordsRef(x: 3, y: 5)
echo "Original coordinates of f: ", f.x, " ", f.y
proc changeCords(a : CordsRef) =
 a.x = 0
 a.y = 0

changeCords(f)
echo "New coordinates of f: ", f.x, " ", f.y

# Tuples - Structural Types 
type Cords3 = (int, int, int)
let map_loc1: Cords3 = (3, 6, 9)
echo &"map_loc1: {map_loc1}"

# using pure pragma.  Requires all references to Colors be qualified
type Colors {.pure.} = enum Red Blue Green
let color1: Colors = Red
var color2: Colors = high Colors

type Colors2 = enum Red Black Yellow
let color3: Colors2 = Red
var color4: Colors2 = high Colors2

echo &"color1, color2: {color1} {color2}"
echo &"color3, color4: {color3} {color4}"

# Compose function examples
proc compose1(f: func, g: func, x: any): any =
 f(g(x))
echo "2+2+2 = ", compose1(addTwo, addTwo, 2)
echo &"2+2+4 = {compose1(addTwo, addTwo, 4)}"


proc compose2(f: (int) -> int, g: (int) -> int): (proc(x: int): int) =
 return proc(x: int): int = f(g(x))

echo "2+2+2 = ", compose2(addTwo, addTwo)(2)

proc compose3(f: (int) -> int, g: (int) -> int): (x: int) -> int =
 (x: int) => f(g(x))

echo "2+2+2 = ", compose3(addTwo, addTwo)(2)

proc compose4[A, B, C](f: A->B, g: B->C): (A)->C =
 (x: A) => f(g(x))

echo "2+2+2 = ", compose4(addTwo, addTwo)(2)

echo "2+2+2 = ", compose4((x: int) => x+2, (x: int)=>x+2)(2)
