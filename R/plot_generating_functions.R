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

make_interpolating_data_plot <- function() {
  interpolating_data <- make_interpolation_data()
  geom_point(data=interpolating_data, aes(x=x, y=y, size=6), alpha=.5)
}

make_interpolating_vlines_plot <- function() {
  interpolating_data <- make_interpolation_data()
  geom_vline(xintercept=interpolating_data$x, alpha=.25)
}

make_vertical_fill_plot <- function(xmin, xmax) {
  d <- data.frame(xmin=xmin, xmax=xmax)
  geom_rect(data=d, aes(xmin=xmin, xmax=xmax, ymin=-Inf, ymax=Inf), alpha=.2, fill="blue")
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
  alphas <- .75*seq(0, 1, length.out=n_plots)^.5
  p <- ggplot()  # Additive identity for ggplot.
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

make_reinsch_basis_plot <- function(knots) {
  basis_splines <- make_reinsch_basis_values(knots)
  plotting_x_vector <- make_plotting_data()
  # Melt the data data frame containing the basis so that we can use facet
  # in ggplot.
  plotting_data_frame <- data.frame(
    x=plotting_x_vector,
    y=basis_splines[,1],
    basis_elem=1
  )
  for(i in 2:ncol(basis_splines)) {
    # Graft on another basis element to the bottom.
    plotting_data_frame <- rbind(
      plotting_data_frame,
      data.frame(x=plotting_x_vector, y=basis_splines[,i], basis_elem=i)
    )
  }
  p <- (ggplot() + geom_line(data=plotting_data_frame, aes(x=x, y=y))
                 + facet_wrap(~ basis_elem)
                 + geom_vline(xintercept=knots, alpha=.25)
                 + theme(strip.background = element_blank(),
                         strip.text.x = element_blank()
                  )
  )
  p
}