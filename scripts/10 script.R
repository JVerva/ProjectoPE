#definir valores iniciais
seed = 57
nam = 950
lambda = 1.99
lambdac = 0.24
pc = 0.1
dim = 100
Z = 1.7 
data = matrix(data = 0, 50, 600)
set.seed(seed)

#gerar os dados
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

#fazer a data frame
tipo = c(rep("limpo",length(meanint)),rep("contaminado",length(meanintc)))
meanintall = c(meanint,meanintc)
data = data.frame(x,meanintall,tipo)

#plot do gráfico
library(ggplot2)
ggplot(data, aes(x = x, y=meanintall, group = tipo, color = tipo)) + 
  geom_point(shape = 16, size = 2) +
  scale_y_continuous(breaks = seq(min(meanintall)-0.001437, max(meanintall)+0.001, by = 0.001)) +
  scale_x_continuous(breaks = round(seq(min(x)-100, max(x), by = 250),1)) +
  labs(x = "Dimensão da amostra", y = "Média da amplitude dos intervalods de confiança") 

#limpar os dados
rm(list = ls())
