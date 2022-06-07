seed = 2018
n = c(5,24,71)
nam = 1970
min = 9
max = 13
mean = abs(max+min)/2
sd = c(sqrt((max-min)^2/12/n[1]),sqrt((max-min)^2/12/n[2]),sqrt((max-min)^2/12/n[3]))

library(ggplot2)

for(i in 1:length(n)){
  set.seed(seed)
  for(j in 1:nam){
    if(j == 1){
      X <- mean(runif(n[i] , min=min, max=max))
    }else{
      X <- append(X, mean(runif(n[i]  , min=min, max=max)))
    }
  }
<<<<<<< Updated upstream
  f<-function(x) {dnorm(x, mean = mean, sd = sd[i])}
  hist(X, breaks = 15, xlim = range(min,max))
  par(new = TRUE)
  plot(f, xlim = range(min,max), axes = FALSE)
  axis(side=4)
=======
  x <- seq(min, max, by = (max-min)/(length(X)-1))
  f<-function(x) {dnorm(x, mean = mean, sd = sd)*n[i]}
  
  library(ggplot2)
  ggplot(data.frame(X),aes(x = X)) + geom_histogram( mapping = aes(y = ..count..),color="Black", fill = "Tomato", bins = 15) + stat_function(fun = f)
>>>>>>> Stashed changes
  if(i == 1){
    Xm <- mean(X)
  }else{
    Xm <- append(Xm,mean(X)) 
  }
}

