source("lab12-14/a/ackley.r")
# zamienia ze soba x lub y jednego z rodzicow z odpowiednia wspolrzedna drugiego rodzica
# np.
# rodzice:
#            [,1]       [,2]
# [1,]  1.0742502  1.0742502
# [2,] -0.9913074 -0.1522789
#
# dzieci:
#            [,1]       [,2]
# [1,] -0.9913074  1.0742502
# [2,]  1.0742502 -0.1522789
crossover_function <- function(object, parents, ...) {
    f <- object@fitness[parents]
    parents <- object@population[parents, , drop = FALSE]
    offsprings <- parents
    x <- sample(c(TRUE, FALSE), 1)
    if (x) {
        offsprings[1, 1] <- parents[1, 2]
        offsprings[1, 2] <- parents[1, 1]
    } else {
        offsprings[2, 1] <- parents[1, 1]
        offsprings[1, 1] <- parents[2, 1]
    }
    f[1] <- -ackley(offsprings[1, ])
    f[2] <- -ackley(offsprings[2, ])
    out <- list(
        children = offsprings,
        fitness = f
    )
    return(out)
}