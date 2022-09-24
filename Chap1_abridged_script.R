# Abriged script for Chapter 1

#### 1.6.1 Table explanation

# We assign to 'x' a sequence of values from 1 to 10
x=c(1:10)
# Which values of 'x' meet the condition 'x>5'?
x
x>5
# To visualize them better, we apply the 'cbind' function
# ('column bind', 'column bind') or 'rbind'
# ('row bind','row union'), to bind 'x' and 'x>5'
# as columns or rows of a table.

# Note: The result of x>5 is coerced into integrals
# so TRUE(true)=1, FALSE(False)=0
cbind(x,y=as.logical(x>5))
rbind(x,y=as.logical(x>5))

# Alternatively, what we saw in the previous sections can be applied:

# We create an empty matrix with 2 columns and 10 rows
z<-matrix(ncol=2,
          nrow = 10)

# We assign to the first column of the matrix z the values of 'x'
z[,1]<-x
# We assign to the second column of matrix z the values of 'x>5'
z[,2]<-x>5 

z

#### 1.7.1 Vectorization

list.str<-list('dt'=data.frame(x=c('a','b'),  #Data.frame
                               y=c(1,2),
                               stringsAsFactors = TRUE),
               # Edit 2022: stringsAsFactors argument of data.frame() function is defaulted to FALSE
               'l'=list('a'='a',              #List
                        'b'=c(1,2,3)),
               'm'=matrix(c(1:9),             #Matrix
                          nrow = 3,
                          ncol = 3),
               'a'=array(c(1:18),             #Array
                         dim = c(3,3,2)),
               'v'=c(1,2,3))                  #Vector

# Coerce factors from column x of table dt, from list.str, 
# to numeric and multiply them by two

as.numeric(list.str$dt$x)*2

#If we apply class() to list.str we get:
class(list.str)
#If we apply class() to list.str$dt we get:
class(list.str$dt)
#If we apply class() to list.str$dt$x we get:
class(list.str$dt$x)
#If we apply class() to list.str$dt$y we get:
class(list.str$dt$y)



#### 1.7.2 The `for` loop.
# We define the variable that will determine the index for the loop

x=c(1:10) # sequence from 1 to 10.

# "for(i in x)" means: "for (each item 'i' in x)"
for (i in x){
  #instruction: show in console the result of multiplying x by 2
  
  x[i]<-x[i]*2 # for each 'i' in x, we are going to assign
  # each element 'i' in x multiplied by 2
  
  print(x[i])  # print each 'i' from x" in console
  
  #The function 'print()' shows in console what is inside the parentheses
}

# Adapt, improve, overcome

# We define a sequence in x
x=c(1:10) 
# We define the (empty) object y where the results of the loop will be stored.
y=c() 

#We define the multiplier m
m=2

# loop:
# loop:
for (i in x){
  y[i]<-x[i]*m 
  
  print(paste(x[i],"x",m, "is",y[i])) 
  
  # The function 'paste()' concatenates the elements inside the parentheses.
}

  
# Applying the  `for` loop to the problem
  for (i in colnames(list.str$dt)){ # for (each i in table column names)
    
    print(paste("class of column",        # show in console:
                i,                        # class of column i
                "is",                     # is 'class(table[[i]])' 
                class(list.str$dt[[i]])))
  }
  # The 'colnames()' function gets the column names of a table.


#### 1.7.3 Conditional Expressions `if`, `else` and `ifelse()`

##### Example 1: `if` and `else`

# We assign a value to variable x
x=3

if(x%%2==0){                     #if (the remainder of x/2 is 0)
  
  print(paste(x, "is even"))      # print in console: x is even
} else{
  
  print(paste(x, "is odd"))  # else, print in console: x is odd
  
}

##### Example 2: `ifelse()`

x<-c(1:10)

ifelse(x%%2==0,
       paste(x, "is even"),
       paste(x, "is odd"))

#### 1.7.4 Brief introduction to functions

ColClass<-function(x){    # Function 'ColClass' is going to have one argument: 'x'
  
  r<-c()                  # Initialize empty variable r
  
  for (i in colnames(x)){ # for (each i in column names of the table defined by  argument 'x')
    
    r[i]<-paste("Class of column", # assign: to each element of r, for each i
                # in x:
                
                i,                     # "the class of column 'i'
                
                "is",                  # is 'class(tabla x[[i]])'"
                
                class(x[[i]]))
  }
  
  
  return(as.character(r))     # Return r
  
  # "return()" returns the result of the variable inside the parentheses.
}

# Assign to variable 'z' the result of the function 'ColClass' applied to 'list.str$dt'

z=ColClass(x=list.str$dt)
z

# Improve

ColClassVal<-function(x){
  if(is.data.frame(x)){ # If objetct x is a data.frame:
    r<-c()
    for (i in colnames(x)){
      r[i]<-paste("Class of column", 
                  i,                     
                  "is",
                  class(x[[i]]))
    }
    
    return(as.character(r))
    
  } else {              # Else, print in console .
    
    print("Object x is not a 'data.frame'")
  }
}

# Assign to variable 't' the result of the function 'ColClassVal' applied to 'list.str$dt'
t=ColClassVal(x=list.str$dt)
t
# Assign to variable 'f' the result of the function 'ColClassVal' applied to 'list.str$v'
f=ColClassVal(x=list.str$v)
f
args(ColClassVal)
