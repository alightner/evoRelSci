library(data.table)
library(bindata)
library(tidyverse)
library(pwr)
library(igraph)
n_set = seq(30,300,by=10)   # set of sample sizes

bin_power = rep(NA, length(n_set))  # binary response hypotheses
rank_power = rep(NA, length(n_set))  # ranked response hypotheses
domain_power = rep(NA, length(n_set))  # knowledge/service domain hypotheses

alpha = 0.05  
n_exp = 500  # number of experiments per sample size (applies to simulation)
corr = 0.3   # medium effect (binary responses)
num_experts = 3

count = 1
for(j in n_set){
  sig_exp = rep(NA, n_exp)
  
  # simulated experiments
  for(i in 1:n_exp){
    
    ## (ranked responses?)
    ## correlated binary responses
    m <- matrix(c(1,corr,corr,1), ncol=2)
    x <- rmvbin(j, margprob = c(0.5, 0.5), bincorr = m) 
    test = fisher.test(x[,1], x[,2])
    sig_exp[i] = test$p.value <= alpha
    
  }
  
  bin_power[count] = mean(sig_exp)
  
  # rank_power[count]
  
  ## contingency table responses (for multiple experts and domains)
  null = rep(1/num_experts, num_experts)
  alt = c(1/(num_experts-1), rep((1-(1/(num_experts-1)))/(num_experts-1), num_experts-1))   # moderate-large effect, assumes three local experts
  dpwr = pwr.chisq.test(w=ES.w1(null,alt), N=j, df=(num_experts-1), sig.level=0.05)
  domain_power[count] = dpwr$power
  
  count = count + 1
}

# ----- Cultural consensus and cognitive division of labor -----------

## estimated cultural competence scores?
# experts = rbeta(50,3,1)
# believers = rbeta(50,3,3)

# customized function for estimating beta distribution parameters
# based on expected mean and var in cultural competence
estBetaParams <- function(mu, var){
  a <- ((1-mu)/var-1/mu)*mu^2
  b <- a*(1/mu-1)
  return(params = list(alpha = a, beta = b))
}

## estimated cultural competence averages
## conservatively estimated based on a modest effect, moderate variance
# community
m1 = 0.5; var1 = 0.025
# experts
m2 = 0.6; var2 = 0.025

a1 <- estBetaParams(m1, var1)$alpha; b1 <- estBetaParams(m1, var1)$beta
a2 <- estBetaParams(m2, var2)$alpha; b2 <- estBetaParams(m2, var2)$beta

# n_set = seq(30,300,by=10)   # set of sample sizes
# n_exp = 500  # number of experiments per sample size (applies to simulation)
exp_power = rep(NA, length(n_set))  # binary response hypotheses

# alpha = 0.05

count = 1
for(i in n_set){
  x <- replicate(n_exp,
                 (wilcox.test(rbeta(i, a1, b1), 
                              rbeta(i, a2, b2))$p.value))
  exp_power[count] <- 1 - (sum(x >= alpha)/length(x))
  count = count + 1
}

# dataframe for power curve plots
df <- data.frame(n=rep(n_set,3), power=c(bin_power, domain_power, exp_power), 
                 wtest=c(rep('binary',length(n_set)), 
                         rep('domains',length(n_set)), 
                         rep('expertise',length(n_set))))

# write.table(df, file='dataset/power_analysis.csv', sep=',', row.names = FALSE)

# ----- Consensus, trust, and social network data -----------





