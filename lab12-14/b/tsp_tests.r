require("GA")
require("TSP")
source("lab12-14/b/fitnes.r")

# filename <- "eil76"
filename <- "berlin52"
file_path <- paste("lab12-14/b/", filename, ".tsp", sep = "")
file <- file(file_path)
tsp <- read_TSPLIB(file)
distance_matrix <- as.matrix(dist(tsp, method = "euclidean"))
size <- max(dim(distance_matrix))

# default:
# population = 50,
# iterations = 1000,
# cross_probability = 0.8,
# mut_probability = 0.2,
# elite_population = 8

# opt <- 545
opt <- 7544
config_name <- "Iterations"
config_values <- c(250, 500, 1000, 2000, 3000)
config <- list()
for (i in seq_len(length(config_values))) {
    config[[i]] <- c(
        population = 50,
        iterations = config_values[i],
        cross_probability = 0.8,
        mut_probability = 0.2,
        elite_population = 8
    )
}

global_avg_results <- c()
global_solutions <- c()
global_distance <- c()
global_distance_from_optimum <- c()
for (param in seq_len(length(config_values))) {
    results <- c()
    for (i in 1:10) {
        genetic <- ga(
            type = "permutation",
            fitnes = fitnes,
            distance_matrix = distance_matrix,
            lower = 1, upper = size,
            popSize = config[[param]]["population"],
            maxiter = config[[param]]["iterations"],
            pcrossover = config[[param]]["cross_probability"],
            pmutation = config[[param]]["mut_probability"],
            elitism = config[[param]]["elite_population"]
        )
        results <- append(results, (-genetic@fitnessValue) - opt)
        global_solutions <- append(global_solutions, toString(genetic@solution[1, ], width = NULL))
        global_distance <- append(global_distance, -genetic@fitnessValue)
        global_distance_from_optimum <- append(global_distance_from_optimum, (-genetic@fitnessValue - opt))
    }
    global_avg_results <- append(global_avg_results, sum(results) / 10)
}
df <- data.frame(
    config_name = config_values,
    avg_distance_from_optimum = global_avg_results
)
write.csv(
    df,
    paste("lab12-14/b/tsp_results/", filename, "_", config_name, ".csv", sep = ""),
    row.names = TRUE
)
df <- data.frame(
    solution = global_solutions,
    distance = global_distance,
    distance_from_optimum = global_distance_from_optimum
)
write.csv(
    df,
    paste("lab12-14/b/tsp_results/", filename, "_", config_name, "_solutions.csv", sep = ""),
    row.names = TRUE
)