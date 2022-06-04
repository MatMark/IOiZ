require("GA")
require("globalOptTests")

source("lab12-14/a/ackley.r")
source("lab12-14/a/selection.r")
source("lab12-14/a/crossover.r")
source("lab12-14/a/mutation.r")

opt_ackley <- getGlobalOpt("Ackleys")
# set 2 dimentional x in {-10, 10} and y in {-10, 10}
bounds_ackley <- list(c(-10, -10), c(10, 10))
names(bounds_ackley) <- c("lower", "upper")

config_name <- "Mutation_function"
config_values <- c(0.02, 0.05, 0.1, 0.2, 0.4)
config <- list()
for (i in seq_len(length(config_values))) {
    config[[i]] <- c(
        population = 50,
        iterations = 500,
        cross_probability = 0.8,
        mut_probability = config_values[i],
        elite_population = 2
    )
}

global_avg_results <- c()
global_solutions_x <- c()
global_solutions_y <- c()
global_solutions_z <- c()
for (param in seq_len(length(config_values))) {
    results <- c()
    for (i in 1:10) {
        genetic <- ga(
            type = "real-valued", fitnes = function(x) -ackley(x),
            lower = bounds_ackley$lower, upper = bounds_ackley$upper,
            popSize = config[[param]]["population"],
            maxiter = config[[param]]["iterations"],
            pcrossover = config[[param]]["cross_probability"],
            pmutation = config[[param]]["mut_probability"],
            elitism = config[[param]]["elite_population"],
            # selection = tournament_selection
            # crossover = crossover_function
            mutation = mutation_function
        )
        results <- append(results, -genetic@fitnessValue)
        global_solutions_x <- append(global_solutions_x, genetic@solution[1])
        global_solutions_y <- append(global_solutions_y, genetic@solution[2])
        global_solutions_z <- append(global_solutions_z, -genetic@fitnessValue)
    }
    global_avg_results <- append(global_avg_results, sum(results) / 10)
}
df <- data.frame(
    config_name = config_values,
    avg_results = global_avg_results
)
write.csv(
    df,
    paste("lab12-14/a/ackley_results_functions/", config_name, ".csv", sep = ""),
    row.names = TRUE
)
df <- data.frame(
    x = global_solutions_x,
    y = global_solutions_y,
    z = global_solutions_z
)
write.csv(
    df,
    paste("lab12-14/a/ackley_results_functions/", config_name, "_solutions.csv", sep = ""),
    row.names = TRUE
)