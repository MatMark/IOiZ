source("lab12-14/ackley.r")
# zamienia ze soba x jednego z rodzicow z y drugiego rodzica
# (wymiana x z x lub y z y miedzy rodzicami nie ma wplywu na ta funkcje)
# np.
# rodzice:
#           [,1]      [,2]
# [1,]  4.410435 -8.091990
# [2,] -3.571726  1.054254
#
# dzieci:
#           [,1]      [,2]
# [1,]  1.054254 -8.091990
# [2,] -3.571726  4.410435
crossover_function <- function(object, parents, ...) {
    f <- object@fitness[parents]
    parents <- object@population[parents, , drop = FALSE]
    offsprings <- parents
    offsprings[1, 1] <- parents[2, 2]
    offsprings[2, 2] <- parents[1, 1]
    f[1] <- -ackley(offsprings[1, ])
    f[2] <- -ackley(offsprings[2, ])
    out <- list(
        children = offsprings,
        fitness = f
    )
    return(out)
}