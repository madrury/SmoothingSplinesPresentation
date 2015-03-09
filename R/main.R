library(ggplot2)

#-------------------------------------------------------------------------------
# Globals
#-------------------------------------------------------------------------------
project_path <- "/Users/matthewdrury/Presentations/smoothing_splines"

paste_paths <- function(...) {
  paste(..., sep='/')
}

true_signal <- function(x) {
  x*x*x*(x-1) + 2*(1/(1+exp(-.5*(x-.5)))) - 3.5*(x > .2)*(x < .5)*(x - .2)*(x - .5)
}

source(paste_paths(project_path, "R", "data_generating_functions.R"))
source(paste_paths(project_path, "R", "plot_generating_functions.R"))

#-------------------------------------------------------------------------------
# Plots for presentation
#-------------------------------------------------------------------------------
# Create plot directory if it does not exist
dir.create(paste_paths(project_path, "plots"))

# training_data.png
# Scatter plot of only the training data
p <- ggplot() + make_training_data_plot()
ggsave(paste_paths(project_path, "plots", "training_data.png"), plot=p)

# fitted_line.png
# Straight line fit superimposed on training data
p <- ggplot() + make_training_data_plot() + make_fitted_line_plot()
ggsave(paste_paths(project_path, "plots", "fitted_line.png"), plot=p)

# overfit_curve.png
# Overfit curve superimposed on training data
p <- ggplot() + make_fitted_spline_plot(df=30) + make_training_data_plot()
ggsave(paste_paths(project_path, "plots", "overfit_curve.png"), plot=p)
