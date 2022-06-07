Lambda = 0.21
Ex=1/lambda
Seed = 1373
N = 438
Vteo = 0.2299254851867

set.seed(Seed) 
rn <- sort(rexp(N,Lambda))
fun <- ecdf(rn)
plot(fun)

Vexp = 1-fun(7)

resp = abs(Vteo-Vexp)

