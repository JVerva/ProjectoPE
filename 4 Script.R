excelFilePath <- "C:\\Users\\joaog\\Downloads\\Utentes.xlsx"

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

Colesterol <- as.factor(as.double(unlist(read_excel(excelFilePath,"Sheet1",Indexes[1], col_types = "text"))))
TAD <- as.factor(as.double(unlist(read_excel(excelFilePath,"Sheet1",Indexes[2], col_types = "text"))))

data <- data.frame(Colesterol,TAD)

library(ggplot2)
ggplot(data, aes(Colesterol, TAD, color = Colesterol )) + geom_point(shape = 16, size = 3, show.legend = FALSE)
