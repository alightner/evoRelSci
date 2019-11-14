library(tidyverse)
library(data.table)
library(igraph)

g <- read_graph('datasets/kenya_hh.gml', format='gml')
df <- read_csv('datasets/netproperties.csv')

# plot(g, vertex.size=5, vertex.label='', vertex.color=cluster)

# betweenness
btwn_plot <- ggplot(df, aes(x=between, y=exposure)) + geom_point() + theme_bw() +
  labs(x='betweenness', y='salience')

# degree
degree_plot <- ggplot(df, aes(x=degree, y=exposure)) + geom_point() + theme_bw() +
  labs(x='degree', y='salience')

# belief glm (degree)
belief_plot <- ggplot(df, aes(x=degree, y=belief)) + geom_point() + theme_bw() + 
  stat_smooth(method='glm', method.args= list(family='binomial'))




