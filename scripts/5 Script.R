Lambda = 0.21
Ex=1/lambda
Seed = 1373
N = 438
Vteo = 0.2299254851867

set.seed(Seed) 
rn <- sort(rexp(N,Lambda))
fun <- ecdf(rn)
data <- fun(rn)
intersect(data,7)
plot(data)

a <- double()
a <- 0
i <- integer()
i <- 0

while(a < 7){
  i=i+1
  a = rn[i]
}

Vexp = 1 - data[i]

resp = abs(Vteo-Vexp)

