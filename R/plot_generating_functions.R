#-------------------------------------------------------------------------------
# Plot generating functions
#-------------------------------------------------------------------------------

make_true_signal_plot <- function() {
  true_signal_data <- make_true_signal_data()
  geom_line(data=true_signal_data, aes(x=x, y=y))
}

make_training_data_plot <- function() {
  training_data <- make_training_data()
  geom_point(data=training_data, aes(x=x, y=y))
}

make_fitted_line_plot <- function() {
  training_data <- make_training_data()
  training_data$fitted_values <- make_fitted_line_values()
  geom_line(data=training_data, aes(x=x, y=fitted_values))
}

make_fitted_spline_plot <- function(df) {
  training_data <- make_training_data()
  training_data$fitted_values <- make_fitted_spline_values(df=df)
  geom_line(data=training_data, aes(x=x, y=fitted_values))
}