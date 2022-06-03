fitnes <- function(trace, distance_matrix) {
    # dodanie na koncu pierwszego miasta
    trace <- c(trace, trace[1])
    # dobieranie miast w pary miedzy ktorymi sie poruszamy
    route <- embed(trace, 2)[, 2:1]
    # zwraca wartosc przeciwna do pokonanego dystansu (minimalizujemy go)
    return(-sum(distance_matrix[route]))
}