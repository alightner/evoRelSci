library(tidyverse)

df <- read_csv('datasets/power_analysis.csv')

# power curve
pwr_curve <- ggplot(df, aes(x=n, y=power, colour=factor(wtest))) + geom_point() +
  geom_smooth(se=FALSE) + theme_bw() + #theme(legend.position = 'none') +
  geom_hline(yintercept = 0.8, linetype=2) + labs(colour='test type') +
  geom_hline(yintercept = 0.9, linetype=3) + labs(colour='test type') +
  ylim(c(0,1))
