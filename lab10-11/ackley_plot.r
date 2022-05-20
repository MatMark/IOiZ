require("plotly")

source("lab10-11/ackley.r")

show_3d_plot <- function() {
    x <- seq(-10, 10, by = 0.1)
    y <- seq(-10, 10, by = 0.1)
    z <- array(0, dim = c(length(x), length(y)))
    for (i in seq_len(length(x))) {
        for (j in seq_len(length(y))) {
            z[i, j] <- ackley(c(x[i], y[j]))
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
            marker = list(size = 5, color = "red", symbol = "x")
        )

    fig <- fig %>% layout()
    print(fig)
}

show_heatmap <- function() {
    x <- seq(-10, 10, by = 0.1)
    y <- seq(-10, 10, by = 0.1)
    z <- array(0, dim = c(length(x), length(y)))
    for (i in seq_len(length(x))) {
        for (j in seq_len(length(y))) {
            z[i, j] <- ackley(c(x[i], y[j]))
        }
    }

    fig <- plot_ly(
        type = "heatmap",
        colorscale = "Jet",
        x = ~x,
        y = ~y,
        z = ~z
    ) %>%
        add_trace(0,
            x = 0, y = 0, z = 0, mode = "markers", type = "scatter",
            marker = list(size = 10, color = "white", symbol = "x")
        )

    fig <- fig %>% layout()
    print(fig)
}

show_contour <- function() {
    x <- seq(-10, 10, by = 0.1)
    y <- seq(-10, 10, by = 0.1)
    z <- array(0, dim = c(length(x), length(y)))
    for (i in seq_len(length(x))) {
        for (j in seq_len(length(y))) {
            z[i, j] <- ackley(c(x[i], y[j]))
        }
    }

    fig <- plot_ly(
        type = "contour",
        colorscale = "Jet",
        x = ~x,
        y = ~y,
        z = ~z
    ) %>%
        add_trace(0,
            x = 0, y = 0, z = 0, mode = "markers", type = "scatter",
            marker = list(size = 10, color = "white", symbol = "x")
        )

    fig <- fig %>% layout()
    print(fig)
}

show_3d_plot()
show_heatmap()
show_contour()