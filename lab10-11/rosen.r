rosen <- function(xx) {
    # http://www.sfu.ca/~ssurjano/


    d <- length(xx)
    xi <- xx[1:(d - 1)]
    xnext <- xx[2:d]

    sum <- sum(100 * (xnext - xi^2)^2 + (xi - 1)^2)

    y <- sum
    return(y)
}