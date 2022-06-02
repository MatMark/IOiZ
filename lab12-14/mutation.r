# zamienia liczbe na przeciwna
# np.
# przed mutacja:
#          [,1]     [,2]
# [1,] 0.741451 6.171031
#  po mutacji:
#           [,1]      [,2]
# [1,] -0.741451 -6.171031
mutation_function <- function(object, parent, ...) {
    parent <- object@population[parent, , drop = FALSE]
    parent <- parent * -1
    return(parent)
}