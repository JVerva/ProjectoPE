seed = 2018
n = c(5,24,71)
nam = 1970
min = 9
max = 13
mean = abs(max+min)/2
sd = sqrt((max-min)^2/12)

for(i in 1:length(n)){
  set.seed(seed)
  for(j in 1:n[i]){
    if(j == 1){
      X <- mean(runif(nam , min=min, max=max))
    }else{
      X <- append(X, mean(runif(nam , min=min, max=max)))
    }
  }
  x <- seq(min, max, by = (max-min)/(length(X)-1))
  f<-function(x) {dnorm(x, mean = mean, sd = sd)*n[i]}
  ggplot(data.frame(X),aes(x = X)) + geom_histogram( mapping = aes(y = ..count..),color="Black", fill = "Tomato", bins = 15) + stat_function(fun = f)
  if(i == 1){
    Xm <- mean(X)
  }else{
    Xm <- append(Xm,mean(X)) 
  }
}
