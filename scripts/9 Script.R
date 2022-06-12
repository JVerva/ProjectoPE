#definir valores iniciais
seed = 431
nam = 600
lambda = 2.33
dim = 100
Z = 3.29 
set.seed(seed)

#gerar os dados
for (i in 1:50){
  for(j in 1:nam){
    data <- rexp(dim*i,lambda)
    if(j == 1){
      X <- mean(data)
      int <- (1/X)*2*Z/sqrt(dim*i)
    }else{
      X <- c(X, mean(data))
      int = append(int, (1/X[j])*2*Z/sqrt(dim*i))
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

#fazer a data frame
data <- data.frame(x, meanint)

#plot do gráfico
library(ggplot2)
ggplot(data, aes(x, meanint, color = meanint)) + 
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  scale_y_continuous(breaks = seq(min(meanint), max(meanint)+0.05, by = 0.05)) +
  scale_x_continuous(breaks = round(seq(min(x)-100, max(x), by = 500),1)) +
  labs(x = "dimensão da amostra", y = "Média da amplitude dos intervalods de confiança") 

#limpar os dados
rm(list = ls())
          