# selekcja turniejowa deterministyczna
# wybiera z grup o liczebnosci 2 osobnikow
# tego o lepszym przystosowaniu
# i ten osobnik w kolejnej populacji ma 2 potomkow
# osobniki do turnieju wybierane są kolejno wedlug wystepowania
tournament_selection <- function(object, ...) {
    f <- object@fitness
    sel <- rep(NA, object@popSize)
    for (i in seq(from = 1, to = object@popSize, by = 2)) {
        if (f[i] > f[i + 1]) {
            sel[i] <- i
            sel[i + 1] <- i
        } else {
            sel[i] <- i + 1
            sel[i + 1] <- i + 1
        }
    }
    out <- list(
        population = object@population[sel, , drop = FALSE],
        fitness = f[sel]
    )
    return(out)
}