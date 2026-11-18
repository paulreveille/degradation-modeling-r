# Stochastic modelling of degradation data (Wiener and Gamma processes)

Team project from the first year of the engineering programme at Ensimag
(Applied Mathematics, 2025), done in a team of four. The project studies how to
model the degradation of a system over time with random processes, estimate their
parameters from data, and predict when a failure threshold will be crossed.

## What the project does

- **Models**: Wiener process (Brownian motion with drift) and Gamma process.
- **Estimation**: maximum likelihood and method of moments, with regular and irregular
  time steps.
- **Validation by simulation**: bias and consistency of the estimators on simulated
  trajectories.
- **Application**: two real degradation datasets (lasers and semiconductors),
  estimated failure dates for a fixed threshold.
- **Extensions**: imperfect maintenance model, non-homogeneous processes.
- **Interactive Shiny app** to simulate trajectories, estimate parameters and explore results.

The full write-up (in French) is in [`report/report.pdf`](report/report.pdf).

## My contribution

I built the **Shiny application** (`shiny_app/app.R`) on my own. The rest of the
project (theory, estimators, simulations, report) was done as a team of four, and I
followed and understood that work without writing most of it.

## Repository layout

```
shiny_app/   interactive application (R, Shiny, bslib)
analysis/    R Markdown: estimators, bias studies, simulations, maintenance, thresholds
data/        lasers and semiconductors datasets (original and with t0 = 0 added)
report/      LaTeX source, figures and compiled PDF (French)
```

## Run the Shiny app

```r
install.packages(c("shiny", "bslib", "shinyWidgets"))
shiny::runApp("shiny_app")
```

The R Markdown files in `analysis/` read the datasets from `../data/`; run them with
the `analysis/` folder as working directory (they need `rmarkdown` and the packages
loaded at the top of each file). The paths were adjusted when reorganising this
repository for publication.

## References

- Kahle, W., Mercier, S., Paroissin, C. (2016), *Degradation processes in reliability*, ISTE-Wiley.
- Ye, Z.-S., Xie, M. (2015), *Stochastic modelling and analysis of degradation for highly reliable products*, Applied Stochastic Models in Business and Industry, 31, 16-32.

Full bibliography in `report/Ref.bib`.
