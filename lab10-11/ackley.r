ackley <- function(xx, a = 20, b = 0.2, c = 2 * pi) {
    # http://www.sfu.ca/~ssurjano/

    d <- length(xx)

    sum1 <- sum(xx^2)
    sum2 <- sum(cos(c * xx))

    term1 <- -a * exp(-b * sqrt(sum1 / d))
    term2 <- -exp(sum2 / d)

    y <- term1 + term2 + a + exp(1)
    return(y)
}