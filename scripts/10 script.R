#definir valores iniciais
seed = 57
nam = 950
lambda = 1.99
lambdac = 0.24
pc = 0.1
dim = 100
Z = 1.7
set.seed(seed)

#gerar os dados
for (i in 1:25){
  nc = pc * dim*i
  for(j in 1:nam){
    data <- rexp(dim*i,lambda)
    datac <- rexp(nc,lambdac)
    datac <- append(datac, data[1:(dim*i-nc)])
    if(j == 1){
      X <- mean(data)
      Xc <- mean(datac)
      int <- (1/X)*2*Z/sqrt(dim*i)
      intc <- (1/Xc)*2*Z/sd(datac)
    }else{
      X <- append(X,mean(data))
      Xc <- append(Xc,mean(datac))
      int <- append(int,(1/X)*2*Z/sqrt(dim*i))
      intc <- append(intc,(1/Xc)*2*qt((1+0.91)/2,dim*i-1)/sd(datac))
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

#fazer a data frame
tipo = c(rep("limpo",length(meanint)),rep("contaminado",length(meanintc)))
meanintall = c(meanint,meanintc)
data = data.frame(x,meanintall,tipo)

#plot do gráfico
library(ggplot2)
ggplot(data, aes(x = x, y=meanintall, group = tipo, color = tipo)) + 
  geom_point(shape = 16, size = 2) +
  scale_y_continuous(breaks = seq(min(meanintall), max(meanintall)+0.1, by = 0.1)) +
  scale_x_continuous(breaks = round(seq(min(x)-100, max(x), by = 250),1)) +
  labs(x = "Dimensão da amostra", y = "Média da amplitude dos intervalods de confiança") 

#limpar os dados
rm(list = ls())
