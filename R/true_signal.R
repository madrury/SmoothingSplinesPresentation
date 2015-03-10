true_signal <- function(x) {
  x*x*x*(x-1) + 2*(1/(1+exp(-.5*(x-.5)))) - 3.5*(x > .2)*(x < .5)*(x - .2)*(x - .5)
}

true_signal_large_hump <- function(x) {
  x*x*x*(x-1) + 2*(1/(1+exp(-.5*(x-.5)))) - 15*(x > .2)*(x < .5)*(x - .2)*(x - .5)
}