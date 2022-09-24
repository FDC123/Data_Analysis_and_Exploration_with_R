# Activities for chapter 1

# if package is installed, require, if not, install and require
using<-function(...) {
  libs<-unlist(list(...))
  req<-unlist(lapply(libs,require,character.only=TRUE))
  need<-libs[req==FALSE]
  if(length(need)>0){ 
    install.packages(need)
    lapply(need,require,character.only=TRUE)
  }
}

using("magrittr")

#--- 1.1: Value Assignment and Pipeline Operators
x<-5
x
5->x
x
x=5
x
x<-c(4) %>% print()


#--- 1.2 Data types

#After each x assignment, use class(x) to get class of x
x<-'a'
x<-1
x<-1L
x<-TRUE
x<-1+4i
x<-4.22
x<-factor(c('a','b'))
x<-NA
x<-NaN
x<-NULL

class(x)

#--- 1.3 Data structures

# vectors
v<-c(1,2,3)
# array
m <- matrix(c(1:9),
            nrow = 3,
            ncol = 3)
#array (array)
a <- array(c(1:18),
           dim = c(3,3,2))

#list
l<-list('a'='a',
        'b'=c(1,2,3))

#data.frame
dt<-data.frame(x=c('a','b'),
               y=c(1,2))

#--- 1.4 Notation for accessing data structures

# For this section, we will create a list of names
# ' list.str', containing the variables of
# 'section 1.3'

list.str<-list('dt'=dt,
                'l'=l,
                'm'=m,
                'a'=a,
                'v'=v)


# ACTIVITY 1:

# Having this list, we can now practice access notations and some functions.
# Answer the questions the best way you can, with code.

# 1. What is the class of object 'list.str'?

class(list.str)

# 2. What are the names of the elements of object 'list.str'?


names(list.str)
# 3. What is the class of the element named 'dt' of object 'list.str'?


class(list.str[["dt"]])
class(list.str$dt)
class(list.str[[1]])

# 4. What are the column names of element named 'dt' of object 'list.str'?


names(list.str[["dt"]])

colnames(list.str[["dt"]])

# 5. What is the class of column 'y' of element 'dt' of object 'list.str'?


class(list.str[["dt"]][,c("y")])

# 6. How can we get the values from the second row of columns 'y' and 'x'
#    of 'dt' element, from 'list.str'?


list.str[["dt"]][2,c("y","x")]


# 7. Select the first array of element 'a'.


list.str[["a"]][,,1]
list.str$a[,,1]

# 8. How many values does the first column of the first array of element 'a' of 'list.str' have?


length(list.str[["a"]][,1,1])


# 9. Get the value of the first row, second column of the first array of 
#    element 'a' of 'list.str'.


list.str$a[1,2,1]

#--- 1.5 Arithmetic operators
1+2
1-2
1*2
2/23
23
23%%2
23%/%2



# Activity 2:

# 1. Square the values of element 'v' of object 'list.str'
list.str$v**2

# 2. Divide the values of element 'a' of 'list.str' by 2
list.str$a/2

#--- 1.6 Logic Operators

#We use logic operators to evaluate conditions.


x=c(1:10)
# Which values in 'x' are '>5'?
x
x>5

cbind(x,y=as.logical(x>5))
rbind(x,y=as.logical(x>5))


#More tests, Comment what the code does. 
x[x>5]
x[x<=5]
x[x==5]
x[x!=5]
x[!(x==5)]
x[x > 8 | x < 5]
x[x > 5 & x <= 8]
isTRUE(x>2)
c(1,2)%in%x


#--- 1.8 R workspace and document handling:

# For this, we need to change the working directory
# via Session > Set working directory > Choose working directory...

# Show in console the current working directory path
getwd()

# Assign to Variable 'root.directory' the current working directory path
root.directory<-getwd()

# We create a new directory called 'dirx'.

dir.create('dirx')

# List the directories inside the working directory
list.dirs()

#Update working directory to 'dirx'
setwd('dirx')

# Assign to variable 'subdirectory.1', the path of the new working directory
subdirectory.1<-getwd()

#List objects from 'Global Environment'
ls()

# Create file 'doc.R' inside the current working directory
file.create('doc.txt')
write(x=c("Dolorem ipsum quia dolor sit amet"),file = "doc.txt")

# Evaluate if 'doc.R' exists in the current working directory
file.exists('doc.txt')

# Show in console metadata of file 'doc.R'
file.info('doc.txt')

# Rename 'doc.R' to 'doc2.R'
file.rename('doc.txt','doc2.txt')

# Re-evaluate if 'doc.R' exists in the current working directory
file.exists('doc.txt')

# Copy contents of file 'doc2.R' in 'doc3.R'
file.copy('doc2.txt','doc3.txt')

# Re-list the files inside the working directory
list.files()


#Creating sub directories

# Assign variable pathSubdirectory.1.2 path 'dirx1/dirx2'
pathSubdirectory.1.2 <-file.path('dirx1','dirx2')



# Create path 'dirx/dirx1/dirx2':

dir.create(path=pathSubdirectory.1.2,
           recursive = TRUE)

# Re-list the files inside the working directory
setwd(subdirectory.1)
list.dirs()

# Update working directory to 'dirx2'
setwd(pathSubdirectory.1.2)

# Assign current working directory to 'subdirectory.1.2'
subdirectory.1.2<-getwd()

# Show function arguments
args(dir.create)

# Return to root directory

setwd(root.directory)

# Delete 'dirx'

unlink("dirx",recursive = TRUE)
