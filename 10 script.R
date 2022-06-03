seed = 57
nam = 950
lambda = 1.99
lambdac = 0.24
pc = 0.1
dim = 100
Z = 1.7 
data = matrix(data = 0, 50, 600)
set.seed(seed)

for (i in 1:25){
  nc = pc * dim*i
  for(j in 1:nam){
    data <- rexp(dim*i,lambda)
    datac <- rexp(nc,lambdac)
    datac <- append(datac, data[1:(dim*i-nc)])
    if(j == 1){
      Sd = sd(data)
      int = Sd * Z * 2
      Sdc = sd(datac)
      intc = Sdc * Z * 2
    }else{
      Sd = append(Sd, sd(data))
      int = append(int, Sd[j] * Z *2)
      Sdc = append(Sdc, sd(datac))
      intc = append(intc, Sd[j] * Z *2)
    }
  }
  if(i==1){
    meanint <- mean(int)
    meanintc <- mean(intc)
    x <- i*dim
  }else{
    meanint <- append(meanint,mean(int))
    meanintc <- append(meanintc,mean(intc))
    x <- append(x, i*dim)
  }
}
plot(x, meanintc, col = "green")
points(x, meanint, col = "red")
