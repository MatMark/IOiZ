require("GA")
require("globalOptTests")
require("plotly")

source("lab10-11/ackley.r")
source("lab10-11/ackley_plot.r")

opt_ackley <- getGlobalOpt("Ackleys")
bounds_ackley <- getDefaultBounds("Ackleys")

show_plot()

# settings for genetic
config_name <- "Iterations"
config_values <- c(100, 250, 500, 1000, 2000)
config <- list()
config[[1]] <- c(
    population = 50,
    iterations = config_values[1],
    cross_probability = 0.8,
    mut_probability = 0.1,
    elite_population = 2
)
config[[2]] <- c(
    population = 50,
    iterations = config_values[2],
    cross_probability = 0.8,
    mut_probability = 0.1,
    elite_population = 2
)
config[[3]] <- c(
    population = 50,
    iterations = config_values[3],
    cross_probability = 0.8,
    mut_probability = 0.1,
    elite_population = 2
)
config[[4]] <- c(
    population = 50,
    iterations = config_values[4],
    cross_probability = 0.8,
    mut_probability = 0.1,
    elite_population = 2
)
config[[5]] <- c(
    population = 50,
    iterations = config_values[5],
    cross_probability = 0.8,
    mut_probability = 0.1,
    elite_population = 2
)

global_avg_results <- c()
for (param in 1:5) {
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
    print("Mean of 10 iterations:")
    print(sum(results) / 10)
    # optimum value
    # print("Optimum value:")
    # print(opt_ackley)
    global_avg_results <- append(global_avg_results, sum(results) / 10)
}
df <- data.frame(
    config_name = config_values,
    avg_results = global_avg_results
)
write.csv(df, paste("lab10-11/", config_name, "_ackley.csv"), row.names = TRUE)