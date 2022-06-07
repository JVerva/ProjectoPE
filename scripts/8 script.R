seed = 182
dim = 688
nam = 1200
lambda = 0.78
Eteo = 1/lambda
nconf = 0.9
alfa = 1-nconf
nfora = alfa/2 * dim
Z =  	1.645
set.seed(seed)

for(j in 1:nam){
  data <- rexp(dim , lambda)
  if(j == 1){
  X <- mean(data)
  Sd <- sd(data)
  int <- 2*Z*Sd
  }else{
    X <- c(X, mean(data))
    Sd <- c(Sd, sd(data))
    int <- c(int, 2*Z*Sd[j])
  }
}

meanint <- mean(int)

rm(list = ls())