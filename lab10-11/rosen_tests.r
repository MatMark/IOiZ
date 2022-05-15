require("GA")
require("globalOptTests")
require("plotly")

source("lab10-11/rosen.r")
source("lab10-11/rosen_plot.r")

opt_rosen <- getGlobalOpt("Rosenbrock")
bounds_rosen <- getDefaultBounds("Rosenbrock")

show_plot()

# settings for genetic
population <- 50
iterations <- 1000
cross_probability <- 0.8
mut_probability <- 0.1
elite_population <- 2

results <- c()
for (i in 1:10) {
    genetic <- ga(
        type = "real-valued", fitnes = function(x) -rosen(x),
        lower = bounds_rosen$lower, upper = bounds_rosen$upper,
        popSize = population,
        maxiter = iterations,
        pcrossover = cross_probability,
        pmutation = mut_probability,
        elitism = elite_population
    )
    summary(genetic)
    # plot(genetic)
    # print(genetic@solution)
    # print(-genetic@fitnessValue)
    results <- append(results, -genetic@fitnessValue)
}
# all results
print("All results:")
print(results)
# mean of 10 iterations
print("Mean of 10 iterations:")
print(sum(results) / 10)
# optimum value
print("Optimum value:")
print(opt_rosen)