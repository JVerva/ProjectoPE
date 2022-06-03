seed = 431
nam = 600
lambda = 2.33
dim = 100
Z = 3.29 
data = matrix(data = 0, 50, 600)
set.seed(seed)

for (i in 1:50){
  for(j in 1:nam){
    data <- rexp(dim*i,lambda)
    if(j == 1){
      Sd = sd(data)
      int = Sd * Z * 2
    }else{
      Sd = append(Sd, sd(data))
      int = append(int, Sd[j] * Z *2)
    }
  }
  if(i==1){
    meanint <- mean(int)
    x <- i*dim
  }else{
    meanint <- append(meanint,mean(int))
    x <- append(x, i*dim)
  }
}
plot(x, meanint)
