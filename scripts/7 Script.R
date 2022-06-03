seed = 262
dim = 108
nam = 7495

set.seed(seed)

for(i in 1:length(n)){
  for(j in 1:nam){
    if(j == 1){
      X <- mean(rbinom(dim , 2, 0.56))
    }else{
      X <- append(X, mean(rbinom(dim , 2, 0.56)))
    }
  }
}

Eteo <- 2*0.56
Eexp <- mean(X)

dif <- abs(Eteo-Eexp)
