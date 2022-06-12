seed = 182
n = 688
nam = 1200
lambda = 0.78
Eteo = 1/lambda
Z =  	1.6449
set.seed(seed)

for(i in 1:nam){
  data <- rexp(n, lambda)
  if(i == 1){
  X <- mean(data)
  int <- (1/X)*2*Z/sqrt(n)
  }else{
    X <- c(X, mean(data))
    int <- c(int, (1/X[i])*2*Z/sqrt(n))
  }
}

meanint <- mean(int)

rm(list = ls())
