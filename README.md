# Project: The Evolution of Religious and Scientific Beliefs as Coexisting Meaning Making Systems

**If you were directed here from the grant proposal:** A PDF of the supplementary materials (figure 1, tables 1 and 2) [can be viewed here](LIGHTNER-supplementary.pdf) or by opening the `LIGHTNER-supplementary.pdf` file in the main directory.

# Overview

This repo is dedicated to publishing materials for a project investigating the evolutionary origins of religious and scientific belief systems, carried out by PhD candidate Aaron Lightner and his PhD committee chair, Edward Hagen. In this project, are specifically examining the relationship between specialized expertise in religion and science (*experts*), and belief and deference to experts based on trust, efficacy, and authority (*believers*). Why are some people highly invested in knowledge and providing decision-making services for their communities? How and why do people in societies choose who to believe?

Our aim is for this repository to be maintained over the course of the proposed study, and to be open for interested collaborators on the project, **The Evolution of Science and Religion as Meaning-Making Systems**. This repo currently provides a more detailed walkthrough of our simulated data, power analysis, planned analyses, and survey drafts with structured and exploratory questions. The project proposal is in a PDF document, `LIGHTNER-subgrant-proposal.pdf`. The code can be viewed and the PDF re-generated in the Rmarkdown (`.Rmd`) file by the same name. All datasets used for preliminary, planned, and power analyses are in the `/datasets` folder, and plots and tables are saved in the `/images` directory.

Here, we provide **supplementary materials** referenced in our fieldwork analyses in the grant proposal, *Investigating the Evolution of Science and Religion as Adaptive Knowledge Specialization*.

# Supplementary Materials 

The supplementary materials referenced in the proposal can be viewed as a PDF in `LIGHTNER-supplementary.pdf`, [or by clicking here](LIGHTNER-supplementary.pdf). Nevertheless, this section also provides an overview of our power analysis (figure 1), predictions (tables 1 and 2) with more commentary about the directories and R scripts, plus some exploratory social network analyses.

## Figure 1. Power analysis for determining sample sizes

Sample sizes in the fieldwork study, as described in the PDF project proposal, are based on a variety of specified test types that each assume medium effect sizes. In the `power-analysis.R` script, we simulated sample sizes and ran hypothetical experiments to generate a dataset, `power-analysis.csv`. In the R script `pwr_curve_plot.R`, this is used to generate the power curve for determining reasonable sample sizes in our fieldwork study:

![power curve plot](images/power-curve.png)

To approximate appropriate sample sizes for structured surveys, we created a power curve by assuming medium effect sizes and simulating appropriate tests on binary and categorical responses (e.g., yes/no responses to questions about trust, efficacy, belief; categorical responses about knowledge and service domains associated with experts; "binary" and "domains", respectively) and Wilcoxon rank-sum tests on competence scores among experts vs. believers ("expertise"). Sample sizes are selected to approximate power >0.8-0.95 across tests.

Generating the power analysis dataset ahead of time will save you time spent on waiting for a simulation to run -- but if you are interested in making revisions and/or re-running and re-generating the `power-analysis.csv` dataset, you can go into `power-analysis.R` and uncomment the `write.table()` function (line 93), then re-run `pwr_curve_plot.R` to re-generate the power curve plot.

## Table 1. Description of fieldwork predictions

![](images/predictions-table1.png)

## Table 2. Specified support criteria for fieldwork predictions

![](images/support-table2.png)

## Social network analysis script

It is difficult to anticipate social network structure prior to data collection. We therefore use the publicly available [Kenyan households contact network](http://www.sociopatterns.org/datasets/kenyan-households-contact-network/) as a working network structure to develop our data analysis plan. The dataset is a `.gml` file and its metadata, including optimal clustering labels that distinguish local modules (`netproperties.csv` and `cluster_members.csv`) are in the `/datasets` directory. The social network structure, with color-coded module clustering, is shown here:

![kenyan households contact network](images/kenya-hh-network.png)

To explore possible social influence on belief distribution, we used a simple simulation of idea transmission originating from a randomly selected "local expert" on the network. We refer to the number of times hearing the transmitted idea as *salience* and, for simplicity, assume that presence/absence of *belief* in the transmitted idea is influenced by the relative salience of the transmitted idea. These assumptions give us a working starting point to demonstrate some of our planned analyses. All manipulations, analyses, and simulations on the social network can be found in `social-network-data-script.R`, and plots are generated in `social-network-plots.R`.

To determine the influence of network structure and individual position on salience of the idea, we consider the impact of various centrality measures on *salience* and probability of believing widespread ideas (*belief* presence). For example, we expect that degree and betweenness centrality measures might be highly relevant to how exposed an individual is to a novel idea, and therefore how salient that idea would be:

![betweenness and idea salience](images/betweenness.png)

![degree and idea salience](images/degree-salience.png)

Our analyses can also use a similar approach to analyzing the impact of network structure/individual position on binary presence/absence data about belief in a novel idea. For example, here we use a generalized linear model to predict probability of belief as a function of network degree:

![glm degree and belief](images/degree-belief.png)







