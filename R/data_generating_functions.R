#-------------------------------------------------------------------------------
# Data generating functions
#-------------------------------------------------------------------------------

make_training_data <- function(signal=true_signal) {
  set.seed(100)
  x_dat <- runif(200)
  y_dat <- signal(x_dat) + rnorm(200, sd=.05)
  training_data <- data.frame(x=x_dat, y=y_dat)
  training_data
}

make_plotting_data <- function(low=.02, high=1) {
  plotting_data <- data.frame(x=seq(low, high, length.out=100))
  plotting_data
}

make_polynomial_data <- function(d, raw_training_data) {
  if(d < 2) {stop("Degree must be 2 or larger.")}
  data <- raw_training_data
  # Add higher degree columns
  for(i in 2:d) {
    this_col_nm <- paste("x", i, sep="_")
    prev_col_nm <- (
      if(i==2) {
        "x"
      } else {
        paste("x", i-1, sep="_")
      }
    )
    data[, this_col_nm] <- (
      data$x * data[, prev_col_nm]
    )
  }
  data
}

make_fitted_line_values <- function() {
  training_data <- make_training_data()
  line_model <- lm(y ~ x, data=training_data)
  plotting_data <- make_plotting_data()
  y_hat <- predict(line_model, newdata=plotting_data)
  y_hat
}

make_fitted_spline_values <- function(df) {
  training_data <- make_training_data()
  spline_model <- smooth.spline(x=training_data$x, y=training_data$y, df=df)
  plotting_data <- make_plotting_data()
  y_hat <- predict(spline_model, x=plotting_data$x)$y
  y_hat
}

make_fitted_polynomial_values <- function(d, low=0, high=1) {
  training_data <- make_training_data()
  training_data <- make_polynomial_data(d=d, training_data)
  line_model <- lm(y ~ ., data=training_data)
  plotting_data <- make_plotting_data(low, high)
  plotting_data <- make_polynomial_data(d=d, plotting_data)
  y_hat <- predict(line_model, newdata=plotting_data)
  y_hat
}

make_fitted_polynomial_values_big_hump <- function(d) {
  training_data <- make_training_data(signal=true_signal_large_hump)
  training_data <- make_polynomial_data(d=d, training_data)
  line_model <- lm(y ~ ., data=training_data)
  plotting_data <- make_plotting_data()
  plotting_data <- make_polynomial_data(d=d, plotting_data)
  y_hat <- predict(line_model, newdata=plotting_data)
  y_hat
}