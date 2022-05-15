require("plotly")

source("lab10-11/ackley.r")

show_plot <- function() {
    x <- seq(-35, 30, by = 0.1)
    y <- seq(-35, 30, by = 0.1)
    z <- array(0, dim = c(651, 651))
    for (i in 1:651) {
        for (j in 1:651) {
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
}