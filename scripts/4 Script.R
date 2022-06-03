#path do ficheiro, sendo que não consegui automatizar o download devido ao login do técnico
excelFilePath <- "C:\\Users\\joaog\\Downloads\\Utentes.xlsx"

#ler a tabela
library(readxl)
Parametros <- names(read_excel(excelFilePath,"Sheet1","A1:D1", col_types = "text", .name_repair = "minimal"))
Parametros <- as.vector(unlist(Parametros))

ParametrosReq <- c("Colesterol", "TAD")
Indexes <- match(ParametrosReq, Parametros)

library(openxlsx)
Indexes <- int2col(Indexes)
for (i in 1:length(Indexes)){
  Indexes[i] <- paste(Indexes[i], "1:", Indexes[i], "77", sep = "")
}

Colesterol <- as.double(unlist(read_excel(excelFilePath,"Sheet1",Indexes[1], col_types = "text")))
TAD <- as.double(unlist(read_excel(excelFilePath,"Sheet1",Indexes[2], col_types = "text")))

#fazer a data frame
data <- data.frame(Colesterol,TAD)

"plot do grafico"
library(ggplot2)
ggplot(data, aes(Colesterol, TAD, color = Colesterol)) + 
  geom_point(shape = 16, size = 3, show.legend = FALSE) +
  scale_y_continuous(breaks = round(seq(min(TAD), max(TAD), by = 2),1)) +
  scale_x_continuous(breaks = round(seq(min(Colesterol)-10, max(Colesterol)+10, by = 10),1))
