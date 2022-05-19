require("GA")
require("globalOptTests")

source("lab10-11/rosen.r")

opt_rosen <- getGlobalOpt("Rosenbrock")
# bounds_rosen <- getDefaultBounds("Rosenbrock")
# set 2 dimentional x in {-10, 10} and y in {-10, 10}
bounds_rosen <- list(c(-10, -10), c(10, 10))
names(bounds_rosen) <- c("lower", "upper")

# settings for genetic

# default settings:
# population = 50,
# iterations = 500,
# cross_probability = 0.8,
# mut_probability = 0.1,
# elite_population = 2

# best settings:
# population = 25,
# iterations = 1000,
# cross_probability = 0.8,
# mut_probability = 0.1,
# elite_population = 8

# test range settings:
# population = c(10, 25, 50, 100, 200),
# iterations = c(100, 250, 500, 1000, 2000),
# cross_probability = c(0.65, 0.7, 0.8, 0.9, 0.95),
# mut_probability = c(0.02, 0.05, 0.1, 0.2, 0.4),
# elite_population = c(0, 1, 2, 4, 8)

config_name <- "Cross_probability"
config_values <- c(0.65, 0.7, 0.8, 0.9, 0.95)
config <- list()
for (i in seq_len(length(config_values))) {
    config[[i]] <- c(
        population = 50,
        iterations = 500,
        cross_probability = config_values[i],
        mut_probability = 0.1,
        elite_population = 2
    )
}

global_avg_results <- c()
global_solutions_x <- c()
global_solutions_y <- c()
global_solutions_z <- c()
for (param in seq_len(length(config_values))) {
    results <- c()
    solutions <- c()
    for (i in 1:10) {
        genetic <- ga(
            type = "real-valued", fitnes = function(x) -rosen(x),
            lower = bounds_rosen$lower, upper = bounds_rosen$upper,
            popSize = config[[param]]["population"],
            maxiter = config[[param]]["iterations"],
            pcrossover = config[[param]]["cross_probability"],
            pmutation = config[[param]]["mut_probability"],
            elitism = config[[param]]["elite_population"]
        )
        # summary(genetic)
        # plot(genetic)
        # print(genetic@solution)
        # print(-genetic@fitnessValue)
        results <- append(results, -genetic@fitnessValue)
        global_solutions_x <- append(global_solutions_x, genetic@solution[1])
        global_solutions_y <- append(global_solutions_y, genetic@solution[2])
        global_solutions_z <- append(global_solutions_z, -genetic@fitnessValue)
    }
    # all results
    # print("All results:")
    # print(results)
    # # mean of 10 iterations
    # print("Mean of 10 iterations:")
    # print(sum(results) / 10)
    # # optimum value
    # print("Optimum value:")
    # print(opt_rosen)
    global_avg_results <- append(global_avg_results, sum(results) / 10)
}
df <- data.frame(
    config_name = config_values,
    avg_results = global_avg_results
)
write.csv(
    df,
    paste("lab10-11/rosen_results/", config_name, ".csv", sep = ""),
    row.names = TRUE
)

df <- data.frame(
    x = global_solutions_x,
    y = global_solutions_y,
    z = global_solutions_z
)
write.csv(
    df,
    paste("lab10-11/rosen_results/", config_name, "_solutions.csv", sep = ""),
    row.names = TRUE
)