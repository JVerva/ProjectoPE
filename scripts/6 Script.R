#definir parâmetros iniciais
seed = 2018
n = c(5,24,71)
nam = 1970
min = 9
max = 13
mean = abs(max+min)/2
sd = c(sqrt((max-min)^2/12/n[1]),sqrt((max-min)^2/12/n[2]),sqrt((max-min)^2/12/n[3]))

for(i in 1:length(n)){
#criar os dados
  set.seed(seed)
  for(j in 1:nam){
    if(j == 1){
      X <- mean(runif(n[i] , min=min, max=max))
    }else{
      X <- append(X, mean(runif(n[i]  , min=min, max=max)))
    }
  }
  f<-function(x) {dnorm(x, mean = mean, sd = sd[i])}
  
#plot dos gráficos  
  title = paste("n =", as.character(n[i]))
  hist(X, breaks = 15, xlim = range(min,max), main = title, xlab = "")
  par(new = TRUE)
  plot(f, xlim = range(min,max), axes = FALSE, xlab = "", ylab = "")
  mtext("Probability density", side = 4, line = -2)
  axis(side=4)
}

#limpar dados
rm(list = ls())
