#-------------------------------------------------------------------------------
# Data generating functions
#-------------------------------------------------------------------------------

make_training_data <- function() {
  set.seed(100)
  x_dat <- runif(200)
  y_dat <- true_signal(x_dat) + rnorm(200, sd=.05)
  training_data <- data.frame(x=x_dat, y=y_dat)
  training_data
}

make_true_signal_data <- function() {
  true_signal_data <- data.frame(x=1:100/100, y=true_signal(1:100/100))
  true_signal_data
}

make_fitted_line_values <- function() {
  training_data <- make_training_data()
  line_model <- lm(y ~ x, data=training_data)
  y_hat <- predict(line_model, newdata=training_data)
  y_hat
}

make_fitted_spline_values <- function(df) {
  training_data <- make_training_data()
  spline_model <- smooth.spline(x=training_data$x, y=training_data$y, df=df)
  y_hat <- predict(spline_model, x=training_data$x)$y
  y_hat
}
