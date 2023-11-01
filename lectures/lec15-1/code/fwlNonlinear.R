n <- 1000000
set.seed(1234)
z <- runif(n=n,min=5,max = 100)
x <- sample(0:1,size = n, replace=TRUE) # no z
cor(x,z)

xb <- exp(-4+.1*z+1*x)/(1+exp(-4+.1*z+1*x))
y <- rbinom(n=n,size=1,prob = xb)
dat <- data.frame(y,x,z)

log_yx <- glm(y~x,family=binomial,data=dat)
log_yxz <- glm(y~x+z,family=binomial,data=dat)
log_yx

trt_dat <- dat
trt_dat$x <- 1
ctrl_dat <- dat
ctrl_dat$x <- 0

trt_resp <- predict(log_yx,type="response", newdata = trt_dat)
ctrl_resp <- predict(log_yx,type="response", newdata = ctrl_dat)
mean(trt_resp - ctrl_resp)
mean(trt_resp)
mean(ctrl_resp)
 
trt_resp <- predict(log_yxz,type="response", newdata = trt_dat)
ctrl_resp <- predict(log_yxz,type="response", newdata = ctrl_dat)
mean(trt_resp - ctrl_resp)
mean(trt_resp)
mean(ctrl_resp)

part_trt_dat <- dat
part_trt_dat$x <- .5

part_trt_resp <- predict(log_yx,type="response", newdata = part_trt_dat)
mean(part_trt_resp)
part_trt_resp <- predict(log_yxz,type="response", newdata = part_trt_dat)
mean(part_trt_resp)




n <- 1000000
set.seed(1234)
z <- runif(n=n,min=5,max = 100)
x <- rnorm(n)
cor(x,z)

xb <- exp(-4+.1*z+1*x)/(1+exp(-4+.1*z+1*x))
y <- rbinom(n=n,size=1,prob = xb)
dat <- data.frame(y,x,z)

log_yx <- glm(y~x,family=binomial,data=dat)
log_yxz <- glm(y~x+z,family=binomial,data=dat)
log_yx
log_yxz

x_dat_half <- dat
x_dat_half$x <- .5

x_half_resp <- predict(log_yx,type="response", newdata = x_dat_half)
mean(x_half_resp)
x_half_resp <- predict(log_yxz,type="response", newdata = x_dat_half)
mean(x_half_resp)


## interactive linear ##
n <- 1000000
set.seed(1234)
z <- 2 + rnorm(n)
x <- rnorm(n) # no z
cor(x,z)

y <- x + z + x*z + rnorm(n)

lm(y ~ x)
lm(y ~ x + z)
lm(y ~ x * z)

lm(y ~ x * I(z-mean(z)))







