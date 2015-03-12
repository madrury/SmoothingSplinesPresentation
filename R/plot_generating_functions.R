#-------------------------------------------------------------------------------
# Plot generating functions
#-------------------------------------------------------------------------------

make_true_signal_plot <- function() {
  true_signal_data <- make_true_signal_data()
  geom_line(data=true_signal_data, aes(x=x, y=y))
}

make_training_data_plot <- function(signal=true_signal, alpha=1) {
  training_data <- make_training_data(signal)
  geom_point(data=training_data, aes(x=x, y=y), alpha=alpha)
}

make_fitted_line_plot <- function() {
  plotting_data <- make_plotting_data()
  plotting_data$fitted_values <- make_fitted_line_values()
  geom_line(data=plotting_data, aes(x=x, y=fitted_values))
}

make_fitted_polynomial_plot <- function(d, alpha=1, low=0, high=1) {
  plotting_data <- make_plotting_data(low=low, high=high)
  plotting_data$fitted_values <- make_fitted_polynomial_values(d=d, low=low, high=high)
  geom_line(data=plotting_data, aes(x=x, y=fitted_values), alpha=alpha)
}

make_fitted_polynomial_plot_big_hump <- function(d) {
  plotting_data <- make_plotting_data()
  plotting_data$fitted_values <- make_fitted_polynomial_values_big_hump(d=d)
  geom_line(data=plotting_data, aes(x=x, y=fitted_values))
}

make_fitted_spline_plot <- function(df) {
  plotting_data <- make_plotting_data()
  plotting_data$fitted_values <- make_fitted_spline_values(df=df)
  geom_line(data=plotting_data, aes(x=x, y=fitted_values))
}

make_fitted_splines_plot <- function(dfv) {
  plotting_data <- make_plotting_data()
  n_plots <- length(dfv)
  alphas <- seq(0, 1, length.out=n_plots)^.5
  p <- geom_blank()  # Additive identity for ggplot.
  for(i in 1:n_plots) {
    plotting_data$fitted_values <- make_fitted_spline_values(df=dfv[i])
    p <- p + geom_line(data=plotting_data, aes(x=x, y=fitted_values), alpha=alphas[i])
  }
  p
}

make_interpolating_spline_plot <- function() {
  plotting_data <- make_plotting_data()
  interpolation_data <- make_interpolation_data()
  plotting_data$fitted_values <- make_interpolating_spline_values(make_interpolation_data())
  geom_line(data=plotting_data, aes(x=x, y=fitted_values))
}