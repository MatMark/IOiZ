require("GA")
require("globalOptTests")

source("lab12-14/c/ackley.r")

opt_ackley <- getGlobalOpt("Ackleys")
# bounds_ackley <- getDefaultBounds("Ackleys")
# set 2 dimentional x in {-10, 10} and y in {-10, 10}
bounds_ackley <- list(c(-10, -10), c(10, 10))
names(bounds_ackley) <- c("lower", "upper")

# settings for genetic
# default settings:
# method = "L-BFGS-B",
# poptim = 0.05,
# pressel = 0.5

config_name <- "Method"
config_values <- c(
    "Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN"
)
# config_values <- c(0, 0.05, 0.3, 0.6, 1)
# config_values <- c(0, 0.2, 0.5, 0.9, 1)

config <- list()
for (i in seq_len(length(config_values))) {
    config[[i]] <- list(
        method = config_values[i],
        poptim = 0.05,
        pressel = 0.5
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
            popSize = 50,
            maxiter = 500,
            pcrossover = 0.8,
            pmutation = 0.1,
            elitism = 2,
            optim = TRUE,
            optimArgs = config[[param]]
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
    paste("lab12-14/c/ackley_results/", config_name, ".csv", sep = ""),
    row.names = TRUE
)
df <- data.frame(
    x = global_solutions_x,
    y = global_solutions_y,
    z = global_solutions_z
)
write.csv(
    df,
    paste("lab12-14/c/ackley_results/", config_name, "_solutions.csv", sep = ""),
    row.names = TRUE
)