UK Rail Track Failure Analysis (2002–2025)

Project Overview
This project analyses long-term trends in broken and buckled rail failures on the UK mainline railway network using annual data from 2002 to 2025. The aim is to explore how rail infrastructure safety has changed over time and to identify suitable statistical models for analysing overdispersed failure count data.
The project applies exploratory data analysis, visualisation, and count-data regression models to support evidence-based insights into rail safety performance.

Research Questions
-What are the long-term trends regarding broken-rail and buckled-rail failures in the UK rail network?
-How does overdispersion impact the statistical modeling of broken and buckled rail failures?

Dataset
The dataset contains annual counts of:
-Broken rail failures
-Buckled rail failures
Source: UK rail infrastructure safety statistics (Network Rail / RSSB)

Methods
-The analysis was conducted in R and includes:
-Descriptive statistics
-Time series visualisation
-Histograms
-Overdispersion diagnostics
-Poisson regression
-Negative binomial regression
-Model comparison using AIC
These methods were used to assess long-term trends and identify the most suitable modelling approach for the data.

Key Findings
-Both broken and buckled rail failures have declined significantly over time.
-Broken rails were historically more frequent and variable than buckled rails.
-The data showed strong overdispersion, making negative binomial models more appropriate than Poisson models.
-The findings support existing research on the effectiveness of proactive rail maintenance and inspection strategies.

Tools Used
-R
-RStudio
-ggplot2
-MASS (Negative Binomial models)
-GitHub

How to Run the Code
1.Download or clone this repository
2.Open the file Intro to data science coursework.R in RStudio
3.Ensure the dataset broken rails and buckled rails.csv is in the same folder as the script
4.Install required packages if needed
5.Run the script to reproduce the analysis and results

Required packages:
-ggplot2
-MASS
-Moment

