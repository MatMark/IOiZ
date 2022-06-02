# zamienia losowo x lub y na wartosc przeciwna
# np.
# przed mutacja:
#             [,1]         [,2]
# [1,] 7.58537e-05 2.112745e-06
#             [,1]          [,2]
# [1,] 7.58537e-05 -2.112745e-06
mutation_function <- function(object, parent, ...) {
    parent <- object@population[parent, , drop = FALSE]
    x <- sample(c(TRUE, FALSE), 1)
    if (x) {
        parent[1] <- parent[1] * -1
    } else {
        parent[2] <- parent[2] * -1
    }
    return(parent)
}