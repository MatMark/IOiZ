# selekcja turniejowa
# wybiera z grup o liczebnosci 2 osobnikow
# tego o lepszym przystosowaniu
# i ten osobnik w kolejnej populacji ma 2 potomkow
# osobniki do turnieju wybierane są kolejnsci losowej
tournament_selection <- function(object, ...) {
    f <- object@fitness
    sel <- rep(NA, object@popSize)

    # wektor liczb od 1 do popSize z losowa kolejnoscia elementow
    v <- 1:object@popSize
    v <- sample(v)

    for (i in seq(from = 1, to = object@popSize, by = 2)) {
        # bierze po 2 elementy i porownuje ktory element ma lepsze przystosowanie
        # elementy sa wybierane w losowych parach
        # (i jest po kolei, ale v ma losowe elementy wiec v[i] ma dowolna wartosc od 1 do popSize)
        if (f[v[i]] > f[v[i + 1]]) {
            sel[v[i]] <- v[i]
            sel[v[i + 1]] <- v[i]
        } else {
            sel[v[i]] <- v[i + 1]
            sel[v[i + 1]] <- v[i + 1]
        }
    }
    out <- list(
        population = object@population[sel, , drop = FALSE],
        fitness = f[sel]
    )
    return(out)
}