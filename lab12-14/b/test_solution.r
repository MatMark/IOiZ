require("TSP")
source("lab12-14/b/fitnes.r")

filename <- "eil76"
file_path <- paste("lab12-14/b/", filename, ".tsp", sep = "")
tsp <- read_TSPLIB(file(file_path))
distance_matrix <- as.matrix(dist(tsp, method = "euclidean"))
# best trace for eil76
trace <- c(1, 33, 63, 16, 3, 44, 32, 9, 39, 72, 58, 10, 31, 55, 25, 50, 18, 24, 49, 23, 56, 41, 43, 42, 64, 22, 61, 21, 47, 36, 69, 71, 60, 70, 20, 37, 5, 15, 57, 13, 54, 19, 14, 59, 66, 65, 38, 11, 53, 7, 35, 8, 46, 34, 52, 27, 45, 29, 48, 30, 4, 75, 76, 67, 26, 12, 40, 17, 51, 6, 68, 2, 74, 28, 62, 73)
# best trace for berlin52
# trace <- c(1, 49, 32, 45, 19, 41, 8, 9, 10, 43, 33, 51, 11, 52, 14, 13, 47, 26, 27, 28, 12, 25, 4, 6, 15, 5, 24, 48, 38, 37, 40, 39, 36, 35, 34, 44, 46, 16, 29, 50, 20, 23, 30, 2, 7, 42, 21, 17, 3, 18, 31, 22)
xy <- paste("lab12-14/b/", filename, ".csv", sep = "")
df <- read.csv(xy, header = FALSE)
X <- df[[2]]
Y <- df[[3]]

solution <- trace
distance <- -fitnes(trace, distance_matrix)

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
    paste("lab12-14/b/tsp_results/opt_", filename, "_", as.integer(distance) ,"_solutions.csv", sep = ""),
    row.names = FALSE, col.names = FALSE, sep = ", ", append = FALSE
)