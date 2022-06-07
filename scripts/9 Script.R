#definir valores iniciais
seed = 431
nam = 600
lambda = 2.33
dim = 100
Z = 3.29 
data = matrix(data = 0, 50, 600)
set.seed(seed)

#gerar os dados
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

#fazer a data frame
data <- data.frame(x, meanint)

#plot do grafico
library(ggplot2)
ggplot(data, aes(x, meanint, color = meanint)) + 
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  scale_y_continuous(breaks = seq(min(meanint), max(meanint), by = 0.005)) +
  scale_x_continuous(breaks = round(seq(min(x)-100, max(x), by = 500),1)) +
  labs(x = "dimensão da amostra", y = "Média da amplitude dos intervalods de confiança") 

#limpar os dados
rm(list = ls())
          