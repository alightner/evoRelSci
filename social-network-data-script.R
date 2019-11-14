library(tidyverse)
library(data.table)
library(igraph)
df1 <- read_csv('datasets/scc2034_household_contact_dataset/scc2034_kilifi_all_contacts_across_households.csv')
df2 <- read_csv('datasets/scc2034_household_contact_dataset/scc2034_kilifi_all_contacts_within_households.csv')
df <- rbind(df1, df2)
cluster <- read_csv('datasets/cluster_members.csv') 
edgelist <- data.frame(m1 = df$m1, df$m2)
g <- simplify(as.undirected(graph_from_edgelist(as.matrix(edgelist))))
g <- delete_vertices(g, degree(g)==0)
cluster <- cluster$x
# write_graph(g, file='datasets/kenya_hh.gml', format='gml')
# plot(g, vertex.size=5, vertex.label='', vertex.color=cluster)
# hist(degree(g))

# simple belief simulation (similar to standard probabilistic "rumor transmission" models)
set.seed(998)
lexp = sample(1:vcount(g),1)

time = 10000
prob_pass = 0.05   # proportion of people passed belief per time step

V(g)$info = 0
V(g)$info[lexp] = 1
adj = adjacent_vertices(g, V(g))
for(t in 1:time){
  tmp = unlist(adj[V(g)$info >= 1])
  heard = sample(tmp, round(prob_pass*length(tmp)))
  V(g)$info[heard] = V(g)$info[heard] + 1
}
info <- V(g)$info - min(V(g)$info)
info <- info/max(info)
# info <- V(g)$info/max(V(g)$info)
# probabilty of belief based on crude measure of number of times hearing it

belief = rep(NA, vcount(g))
rand_num = runif(length(belief),0,1)
for(i in 1:length(belief)) ifelse(rand_num[i]<= info[i], belief[i]<-1, belief[i]<-0)
# for(i in 1:length(belief)) belief[i] <- sample(c(0,1),1,prob=c((1-info[i]), info[i]))
belief[lexp] <- 1

# degree, betweenness

# consensus 
V(g)$b <- belief
peers = rep(NA, vcount(g))
for(i in 1:vcount(g)){
  peers[i] <- mean(V(g)$b[unlist(adjacent_vertices(g,i))])
}
# plot(peers, info)
df <- data.frame(id = 1:vcount(g),
                 belief, exposure = info, peers,
                 expert = 0,
                 between = betweenness(g),
                 degree = degree(g),
                 closeness = closeness(g),
                 hub = hub_score(g)$vector,
                 coreness = coreness(g)
); df$expert[lexp] <- 1

# write.table(df, file='datasets/netproperties.csv', sep=',', row.names = FALSE)

