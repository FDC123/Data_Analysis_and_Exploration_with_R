# Chapter 3: Loop functions: The `apply` Family

### 3.1 The `apply()` function

set.seed(1)

x<-matrix(round(rnorm(500),3), 
          # Create matrix( of 500 elements with normal distribution,
          nrow=100,           # Distributed in 100 rows and 5 columns)
          ncol=5)             
# The round() function, limits the number of decimals,
# in this case, the limit is 3 decimals

head(x)

round(apply(x, 2, mean),3)    # apply to (x, on columns, the function "mean()")

# We manually check the mean of some column

round(mean(x[,1]),3)

y<-apply(x, 1, sum)     # apply to (x, on rows, the function "sum()")

# visualize
cbind(head(x),sum=y[1:6])

# We manually check the sum of some row

sum(x[1,])

### 3.2 The `lapply()` function

#### Example 1
movies <- c("AVENGERS","JOKER","BRAVE","UP")   

movies_lowercase <-lapply(movies, tolower)

str(movies_lowercase)                                

# We can use the "unlist()" function to transform the result of "lapply()" to a vector.

movies_lowercase <-unlist(lapply(movies,tolower))

str(movies_lowercase)

#### Example 2

mat.l<-list("A"=matrix(1:9,nrow=3,ncol=3),
            "B"=matrix(11:26,nrow=4,ncol=4),
            "C"=matrix(31:34,nrow=2,ncol=2))

mat.l.col2<-lapply(mat.l,function(x) x[,2])

mat.l.row2<-lapply(mat.l,function(x) x[2,])

mat.l
str(mat.l.col2)
str(mat.l.row2)

unlist(mat.l.col2)
unlist(mat.l.row2)

### 3.3 The `sapply()` function

movies <- c("AVENGERS","JOKER","BRAVE","UP")   
movies_lowercase <-as.character(sapply(movies, 
                                       tolower))     

str(movies_lowercase) 

#### Example 2

(mat.l<-list("A"=matrix(1:9,nrow=3,ncol=3),
             "B"=matrix(11:26,nrow=4,ncol=4),
             "C"=matrix(31:34,nrow=2,ncol=2)))

mat.l.row2col2<-sapply(mat.l,function(x) x[2,2])

str(mat.l.row2col2)

### 3.4 The `mapply()` function

#### Example 1
mapply(sum,    # "mappply" addition to 3 vectors with a sequence from 1 to 5
       1:5,    # i.e: 1+1+1, 2+2+2, etc.
       1:5, 
       1:5)

# This is basically the same as:
1:5+1:5+1:5

# If we made a matrix with the same values spread over 3 columns:
x<-matrix(c(rep(1:5,3)),
          nrow=5,
          ncol=3)

x
# We would get the same result if:
apply(x,1,sum)


#### Example 2 
x<-data.frame(V1=c(1:5),
V2=c(6:10),
V3=c(11:15))

y<-data.frame(V1=c(1:5),
              V2=c(6:10),
              V3=c(11:14,16))
# Look at the output of the "identical()" function
#   Note: identical() only works if both tables have the same dimensions 
#          and column names.
identical(x,y)

# We know that in general, x is not identical to y, but we want
# to know which column is different.

mapply(identical,x,y)

data.frame(identical_x_vs_y=mapply(identical,x,y))


### 3.5 The `vapply()` function

set.seed(100)
dat<-data.frame(X=rnorm(n=100,     # We create a data.frame with 3 columns (X,Y,Z)
                        mean=0,    # Each one composed of 100 obs. with normal 
                        sd=1),     # distribution, different means, same std.
                Y=rnorm(n=100,
                        mean=1,
                        sd=1),
                Z=rnorm(n=100,
                        mean=2,
                        sd=1))

sapply(dat,mean)

# In this case, we expect the output to be of class "numeric", length=1
vapply(dat,mean,numeric(1))

# Notice what happens when we define the length of the output to 2.


vapply(dat,mean,numeric(2))

# Basically R is telling you, that an output of 2 numbers was expected for each i,
# but the operation returned 1 for each i

# Now, by applying the summary() function to each column, we expect an output
# of length 6 for each i.

vapply(dat,summary,numeric(6))

# The summary() function acts in different ways, depending 
# on the class to which it is applied in this case, because the class is "numeric",
# it returns a statistical summary of the columns.


t(vapply(dat,summary,numeric(6)))

# The "t()" function is used to transpose matrices, transpose means
# that we are going to exchange rows for columns, and vice versa. 
# Some sort of dimensional rotation.


### 3.6 The `tapply()` function

set.seed(200)

# We create a data set, where we simulate the effect of diet and physical training in
# people with morbid obesity.

# We create the variable to control the number of samples
np=4*100 #number of patients

weight_control<-data.frame(patient_id = as.character(paste0("patient_", 1:np)),
                           age_years = as.integer(round(rnorm(np, mean = 50, sd =8),
                                                        digits = 0)),
                           starting_weight_kg=rnorm(np,300,10),
                           final_weight_kg = c(rnorm(np/4,mean=100,sd=10),
                                               rnorm(np/4,mean=70,sd=5),
                                               rnorm(np/4,mean=90,sd=5),
                                               rnorm(np/4,mean=300,sd=10)),
                           height_m=rnorm(np, mean = 1.75, sd =0.08),
                           gender_binary=as.factor(rep_len(c("f","m"),
                                                           np)),
                           treatment_category = gl(4, 
                                                   np/4,
                                                   labels = c("diet",
                                                              "diet_and_physical_training",
                                                              "physical_training",
                                                              "control")))


# The function "gl()" generates a vector of factors defined 
# by (n levels, n members x level, level labels)


## Feature engineering

# Starting and final bmi calculations

weight_control$starting_bmi<-weight_control$starting_weight_kg/(weight_control$height_m**2)
weight_control$final_bmi<-weight_control$final_weight_kg/(weight_control$height**2)

# Starting and final bmi classification
#  We create a function that helps us do 
#  the classification automatically.

BMI_classifier<-function(x){
  as.factor(ifelse(x<18.5,"low_weight",
                   ifelse(x>=18.5 & 
                            x<25,"normal_weight",
                          ifelse(x>=25 & 
                                   x<30,"overweight",
                                 ifelse(x>=30 &
                                          x<35,"mild_obesity",
                                        ifelse(x>=35 & 
                                                 x<40,"obesity",
                                               "morbid_obesity"))))))
}

weight_control$starting_bmi_category<-BMI_classifier(weight_control$starting_bmi)


weight_control$final_bmi_category<-BMI_classifier(weight_control$final_bmi)

# Calculation of differences (deltas)

weight_control$delta_weight_kg<-weight_control$starting_weight_kg-weight_control$final_weight_kg

weight_control$delta_bmi<-weight_control$starting_bmi-weight_control$final_bmi


# Generate a data summary
summary(weight_control)

# We want to EXPLORE if the treatments had any indication of effect

treatment_effects<-tapply(weight_control$final_bmi,           # X
                          weight_control$treatment_category,  # INDEX
                          summary)                            # FUN

treatment_effects

treatment_effects.df<- do.call(rbind,               # Function
                               treatment_effects) # Argument list

treatment_effects.df

# The "do.call()" function allows you to call any function in R, 
# but instead of writing the arguments one by one, you can use 
# a list to hold the function's arguments.
# do.call() is another loop function.


### 3.7 The `rapply()` function

# We create the function MinMaxNorm

MinMaxNorm<-function(x){
  y<-(x-min(x))/(max(x)-min(x))
}


weight_control.norm<-rapply(weight_control, # object
                            f=MinMaxNorm,              # function
                            classes = "numeric",       # class limit
                            how = "replace")

head(weight_control.norm)[,c(1:5)]

head(weight_control)[,c(1:5)]

plot(density(weight_control$final_bmi),
     main= "Density for final bmi (untransformed)")
plot(density(weight_control.norm$final_bmi),
     main= "Density for final bmi (min max transformed)")


# If we wanted to obtain a dataframe where the columns are minimum and maximum values,
# and the rows the names of the "numerical" columns of "weight_control":

weight_control.minmax<-data.frame(min= rapply(weight_control,
                                              f=min,
                                              classes = "numeric",
                                              deflt = NULL,
                                              how = "unlist"),
                                  max=rapply(weight_control,
                                             f=max,
                                             classes = "numeric",
                                             deflt = NULL,
                                             how = "unlist"))
weight_control.minmax
