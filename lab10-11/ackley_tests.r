require("GA")
require("globalOptTests")
require("plotly")

source("lab10-11/ackley.r")
source("lab10-11/ackley_plot.r")

opt_ackley <- getGlobalOpt("Ackleys")
bounds_ackley <- getDefaultBounds("Ackleys")

# show_plot()

# settings for genetic
# default settings:
# population = 50,
# iterations = 1000,
# cross_probability = 0.8,
# mut_probability = 0.1,
# elite_population = 2

config_name <- "Elite_population"
config_values <- c(0, 1, 2, 4, 8)
config <- list()
for (i in seq_len(config_values)) {
    config[[i]] <- c(
        population = 50,
        iterations = 1000,
        cross_probability = 0.8,
        mut_probability = 0.1,
        elite_population = config_values[i]
    )
}

global_avg_results <- c()
for (param in seq_len(config_values)) {
    results <- c()
    for (i in 1:10) {
        genetic <- ga(
            type = "real-valued", fitnes = function(x) -ackley(x),
            lower = bounds_ackley$lower, upper = bounds_ackley$upper,
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
    }
    # all results
    # print("All results:")
    # print(results)
    # mean of 10 iterations
    # print("Mean of 10 iterations:")
    # print(sum(results) / 10)
    # optimum value
    # print("Optimum value:")
    # print(opt_ackley)
    global_avg_results <- append(global_avg_results, sum(results) / 10)
}
df <- data.frame(
    config_name = config_values,
    avg_results = global_avg_results
)
write.csv(
    df,
    paste("lab10-11/ackley_results/", config_name, "_ackley.csv"),
    row.names = TRUE
)