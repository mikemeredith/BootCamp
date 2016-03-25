# Day 1: Intro to R
# Updated on: 22 Oct 2015

2 + 3 
2 *3
2/3
3^2
(3+2)*5
5*4+3
7-3

# Create objects
# --------------
my <- 3  # my 'gets' 3
my
total <- 3+7+9
total
my * total
rm(total) # to remove an object
total  # gone
my     # still there

# Create vectors
# --------------
prm <- c(2,3,5,7,11,13,17,23,29,31,37,41)
prm
prm / 3

sqrl <- c(746, 1016, 830, 860)
sqrl
# 1 ounce = 28.6 grams
sqrl / 28.6
sqrl  # not changed
sqrlOunce <- sqrl / 28.6

sum(sqrl)
max(sqrl)
min(sqrl)
length(sqrl)
mean(sqrl)

?max # ? useful for function name

prm
prm[3:8] # [ ] indexing
prm[-9] # [-9] -ve index
prm(3:8) # Error: () for functions, prm not a function!


# Data types
# ----------
vn <- c(3.4, 5.6, 7.8)  # numeric
vn
vc <- c("Gopal", "Lisa", 'Kuit')  # character
vc
vl <- c(TRUE, FALSE, TRUE)  # logical
vl

# A bit more about logical (Boolean) operations
prm == 5
prm < 5

# What happens if we try to mix data types?
c(1, 2, "Abdi", TRUE)

# Names for a vector
# ------------------
names(vn) <- c("Jan", "Feb", "Mar")
vn

islands  # A built-in data set in R
?islands
class(islands)
# Use names for indexing
islands["Borneo"]
islands[8]

# Data frames
# -----------
trees
?trees
class(trees)
View(trees)
trees$Height
class(trees$Height)
str(trees)  # Gives all the classes

# Make our own data frame
data.frame(vl, vc, vn)
data.frame(snow=vl, observer=vc, rainfall=vn)

# Factors
# -------
chickwts
str(chickwts)
summary(chickwts)
chickwts$feed  # This is a 'factor' = categorical variable

# Lists
# -----
mylist <- list(trees=trees, primes=prm, ABC=LETTERS, pi)
str(mylist)
mylist$primes
mylist[[2]]
mylist[[4]]
mylist[2]
mylist[[2]] * 2
mylist[2] * 2



