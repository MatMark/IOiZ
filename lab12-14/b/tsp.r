require("GA")
require("TSP")
source("lab12-14/b/fitnes.r")

filename <- "eil76"
file_path <- paste("lab12-14/b/", filename, ".tsp", sep = "")
tsp <- read_TSPLIB(file(file_path))
distance_matrix <- as.matrix(dist(tsp, method = "euclidean"))
size <- max(dim(distance_matrix))

genetic <- ga(
    type = "permutation",
    fitnes = fitnes,
    distance_matrix = distance_matrix,
    lower = 1, upper = size,
    popSize = 50,
    maxiter = 500,
    pcrossover = 0.8,
    pmutation = 0.1,
    elitism = 2
)

xy <- paste("lab12-14/b/", filename, ".csv", sep = "")
df <- read.csv(xy, header = FALSE)
X <- df[[2]]
Y <- df[[3]]

solution <- genetic@solution[1, ]
distance <- -genetic@fitnessValue

print(solution)
print(distance)
x_rows <- c()
y_rows <- c()
for (row in seq_len(length(solution))) {
    x_rows <- append(x_rows, X[solution[row]])
    y_rows <- append(y_rows, Y[solution[row]])
}
df <- data.frame(
    solution,
    x_rows,
    y_rows
)
write.table(
    df,
    paste("lab12-14/b/tsp_results/", filename, "_", as.integer(distance) ,"_solutions.csv", sep = ""),
    row.names = FALSE, col.names = FALSE, sep = ", ", append = FALSE
)