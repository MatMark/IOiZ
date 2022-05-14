require("GA")
require("globalOptTests")

library(plotly)

opt_rosen <- getGlobalOpt("Rosenbrock")
bounds_rosen <- getDefaultBounds("Rosenbrock")

x <- seq(-3, 3, by = 0.1)
y <- seq(-3, 3, by = 0.1)
z <- array(0, dim = c(61, 61))
for (i in 1:61) {
    for (j in 1:61) {
        z[i, j] <- rosen(c(x[i], x[j]))
    }
}

fig <- plot_ly(
    type = "surface",
    contours = list(
        z = list(show = TRUE, size = 0.01, project = list(z = TRUE))
    ),
    x = ~x,
    y = ~y,
    z = ~z
) %>%
    add_trace(0,
        x = 1, y = 1, z = 0, mode = "markers", type = "scatter3d",
        marker = list(size = 5, color = "red", symbol = 104)
    )

fig <- fig %>% layout()
print(fig)

opt_ackley <- getGlobalOpt("Ackleys")
bounds_ackley <- getDefaultBounds("Ackleys")

x <- seq(-3, 3, by = 0.1)
y <- seq(-3, 3, by = 0.1)
z <- array(0, dim = c(61, 61))
for (i in 1:61) {
    for (j in 1:61) {
        z[i, j] <- ackley(c(x[i], x[j]))
    }
}

fig <- plot_ly(
    type = "surface",
    contours = list(
        z = list(show = TRUE, size = 0.01, project = list(z = TRUE))
    ),
    x = ~x,
    y = ~y,
    z = ~z
) %>%
    add_trace(0,
        x = 0, y = 0, z = 0, mode = "markers", type = "scatter3d",
        marker = list(size = 5, color = "red", symbol = 104)
    )

fig <- fig %>% layout()
print(fig)