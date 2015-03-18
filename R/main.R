library(ggplot2)

#-------------------------------------------------------------------------------
# Globals
#-------------------------------------------------------------------------------
project_path <- "/Users/matthewdrury/Presentations/smoothing_splines"

paste_paths <- function(...) {
  paste(..., sep='/')
}

save_plot <- function(p, filename) {
  ggsave(filename=paste_paths(project_path, "plots", filename), plot=p, width=6, height=5)
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
save_plot(p, "training_data.png")

# fitted_line.png
# Straight line fit superimposed on training data
p <- ggplot() + make_training_data_plot() + make_fitted_line_plot()
save_plot(p, "fitted_line.png")

# overfit_polynomial.png
# High degree polynomial overfit to data
p <- ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=50, low=.025, high=1)
save_plot(p, "overfit_polynomial.png")

# cubic_fit_to_training.png
# A cubic polynomial fit to the training data
p <- ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=3)
save_plot(p, "cubic_fit_to_training.png")

# cubic_endpoint_behaviour.png
# Cubic fit extrapolated past the data
p <- (ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=3, low=-.2, high=1.2)
      + scale_x_continuous(limits=c(-.2, 1.2))
)
save_plot(p, "cubic_endpoint_behaviour.png")

# high_degree_endpoint_behaviour.png
# High degree fit extrapolated past the data
p <- ggplot() + make_training_data_plot() + make_fitted_polynomial_plot(d=50, low=0, high=1)
save_plot(p, "high_degree_endpoint_behaviour.png")

# cubics_fit_to_training.png
# Two cubics fit to different versions of training data, demonstrating non
# locality of polynomial fits.
p <- (ggplot()
      + make_training_data_plot(signal=true_signal_large_hump)
      + make_fitted_polynomial_plot_big_hump(d=3)
      + make_training_data_plot(signal=true_signal, alpha=.5)
      + make_fitted_polynomial_plot(d=3, alpha=.5)
)
save_plot(p, "cubics_fit_to_training.png")

# overfit_curve.png
# Overfit curve superimposed on training data
p <- ggplot() + make_fitted_spline_plot(df=30) + make_training_data_plot()
save_plot(p, "overfit_curve.png")

# splines_of_increasing_roughness.png
# Various splines with increasing degrees of freedom overlayed on the data
p <- (make_fitted_splines_plot(dfv=seq(2^.5, 20^.5, length.out=20)^2)
               + make_training_data_plot()
)
save_plot(p, "splines_of_increasing_roughness.png")

# interpolating_spline.png
# A natural spline interpolating four points
p <- (ggplot() + make_interpolating_spline_plot()
               + make_interpolating_data_plot()
)
save_plot(p, "interpolating_spline.png")

# linear_parts_of_spline.png
# A natural interpolating spline with the linear part highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=-Inf, xmax=1/7)
               + make_vertical_fill_plot(xmin=6/7, xmax=Inf)
               + make_interpolating_vlines_plot()
               + make_interpolating_spline_plot()
               + make_interpolating_data_plot()
)
save_plot(p, "linear_parts_of_spline.png")

# cubic_parts_of_spline.png
# A natural interpolating spline with the cubic parts highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=.2, xmax=.4)
      + make_vertical_fill_plot(xmin=.4, xmax=.6)
      + make_vertical_fill_plot(xmin=.6, xmax=.8)
      + make_interpolating_vlines_plot()
      + make_interpolating_spline_plot()
      + make_interpolating_data_plot()
)
save_plot(p, "cubic_parts_of_spline.png")

# first_part_of_spline.png
# A natural interpolating spline with the first section highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=-Inf, xmax=.2)
      + make_interpolating_vlines_plot()
      + make_interpolating_spline_plot()
      + make_interpolating_data_plot()
)
save_plot(p, "first_part_of_spline.png")

# middle_part_of_spline.png
# A natural interpolating spline with a middle section highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=.2, xmax=.6)
      + make_interpolating_vlines_plot()
      + make_interpolating_spline_plot()
      + make_interpolating_data_plot()
)
save_plot(p, "middle_part_of_spline.png")

# last_cubic_part_of_spline.png
# A natural interpolating spline with the second to last part highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=.6, xmax=.8)
      + make_interpolating_vlines_plot()
      + make_interpolating_spline_plot()
      + make_interpolating_data_plot()
)
save_plot(p, "last_cubic_part_of_spline.png")

# last_part_of_spline.png
# A natural interpolating spline with the last section highlighted
p <- (ggplot() + make_vertical_fill_plot(xmin=.8, xmax=Inf)
      + make_interpolating_vlines_plot()
      + make_interpolating_spline_plot()
      + make_interpolating_data_plot()
)
save_plot(p, "last_part_of_spline.png")

even_knots <- 0:10 / 10
p <- make_reinsch_basis_plot(knots=even_knots[2:10])
save_plot(p, "reinsch_basis.png")
