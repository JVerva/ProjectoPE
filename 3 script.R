excelFilePath <- "/home/verva/Downloads/QualidadeARO3.xlsx"

library(readxl)
Estacoes <- names(read_excel(excelFilePath,"Sheet1","A1:J1", col_types = "text", .name_repair = "minimal"))
Estacoes <- as.vector(unlist(Estacoes))

EstacoesReq <- c("Restelo", "Entrecampos")
Indexes <- match(EstacoesReq, Estacoes)
library(openxlsx)
Indexes <- int2col(Indexes)
for (i in 1:length(Indexes)){
  Indexes[i] <- paste(Indexes[i], "1:", Indexes[i], "8785", sep = "")
}
for (i in 1:length(Indexes)){
  if(i==1){
    nozono <- read_excel(excelFilePath,"Sheet1",Indexes[i], col_types = "text")
  }else{
    nozono <- append(nozono,read_excel(excelFilePath,"Sheet1",Indexes[i], col_types = "text"))
  }
}

nozono <- as.double(unlist(nozono))

for(i in 1:length(EstacoesReq)){
  if(i == 1){
    Estacoes <- rep(EstacoesReq[i],8784)
  }else{
   Estacoes <- append(Estacoes, rep(EstacoesReq[i],8784)) 
  }
}
rm(EstacoesReq)

Estacoes<-as.factor(Estacoes)
nozono<- nozono
data <- data.frame(Estacoes,as.factor(nozono))

library(ggplot2)
ggplot(data , aes(x = nozono)) + geom_histogram(colour = "Green", fill = "Gray",bins = 20) + facet_wrap(facets = vars(Estacoes))
