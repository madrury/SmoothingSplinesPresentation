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

source(paste_paths(project_path, "R", "true_signal.R"))
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

# overfit_polynomial.png
# High degree polynomial overfit to data
p <- ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=50)
ggsave(paste_paths(project_path, "plots", "overfit_polynomial.png"), plot=p)

# cubic_fit_to_training.png
# A cubic polynomial fit to the training data
p <- ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=3)
ggsave(paste_paths(project_path, "plots", "cubic_fit_to_training.png"), plot=p)

# cubics_fit_to_training.png
# Two cubics fit to different versions of training data, demonstrating non
# locality of polynomial fits.
p <- (ggplot()
      + make_training_data_plot(signal=true_signal_large_hump)
      + make_fitted_polynomial_plot_big_hump(d=3)
      + make_training_data_plot(signal=true_signal, alpha=.5)
      + make_fitted_polynomial_plot(d=3, alpha=.5)
)
ggsave(paste_paths(project_path, "plots", "cubics_fit_to_training.png"), plot=p)

# overfit_curve.png
# Overfit curve superimposed on training data
p <- ggplot() + make_fitted_spline_plot(df=30) + make_training_data_plot()
ggsave(paste_paths(project_path, "plots", "overfit_curve.png"), plot=p)
