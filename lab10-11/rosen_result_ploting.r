require("plotly")

source("lab10-11/rosen.r")

filename <- "Population"
x_title <- "Populacja"
y_title <- "Średnia odleglosc od minimum globalnego"
# Obie funkcje mają minimum w 0 więc wynik jest jednocześnie odległością


file_path <- paste("lab10-11/rosen_results/", filename, ".csv", sep = "")
solution_path <- paste(
    "lab10-11/rosen_results/",
    filename,
    "_solutions.csv",
    sep = ""
)

df <- read.csv(solution_path, header = TRUE)
x <- seq(-10, 10, by = 0.1)
y <- seq(-10, 10, by = 0.1)
z <- array(0, dim = c(length(x), length(y)))

df2 <- read.csv(file_path, header = TRUE)
x2 <- paste(df2[["config_name"]])
y2 <- round(df2[["avg_results"]], digits = 5)
data <- data.frame(x2, y2)

for (i in seq_len(length(x))) {
    for (j in seq_len(length(y))) {
        z[i, j] <- rosen(c(x[i], y[j]))
    }
}
fig <- plot_ly(
    type = "contour",
    colorscale = "Jet",
    x = ~x,
    y = ~y,
    z = ~z
) %>%
    add_trace(0, name=paste(x_title, ": ", x2[1], sep = ""),
        x = df[["x"]][1:10], y = df[["y"]][1:10], z = 0, mode = "markers", type = "scatter",
        marker = list(size = 5, color = "#ff0000", symbol = "x")
    ) %>%
    add_trace(0, name=paste(x_title, ": ", x2[2], sep = ""),
        x = df[["x"]][11:20], y = df[["y"]][11:20], z = 0, mode = "markers", type = "scatter",
        marker = list(size = 5, color = "#FFFF00", symbol = "x")
    ) %>%
    add_trace(0, name=paste(x_title, ": ", x2[3], sep = ""),
        x = df[["x"]][21:30], y = df[["y"]][21:30], z = 0, mode = "markers", type = "scatter",
        marker = list(size = 5, color = "#00FF00", symbol = "x")
    ) %>%
    add_trace(0, name=paste(x_title, ": ", x2[4], sep = ""),
        x = df[["x"]][31:40], y = df[["y"]][31:40], z = 0, mode = "markers", type = "scatter",
        marker = list(size = 5, color = "#00FFFF", symbol = "x")
    ) %>%
    add_trace(0, name=paste(x_title, ": ", x2[5], sep = ""),
        x = df[["x"]][41:50], y = df[["y"]][41:50], z = 0, mode = "markers", type = "scatter",
        marker = list(size = 5, color = "#FF00FF", symbol = "x")
    )

fig <- fig %>% layout(legend=list())
print(fig)

fig <- plot_ly(data,
    x = ~x2, y = ~y2, type = "bar", text = y2,
    textposition = "outside"
) %>%
    layout(
        plot_bgcolor = "#e5ecf6",
        xaxis = list(
            autotypenumbers = "strict",
            title = x_title,
            zerolinecolor = "#ffff",
            zerolinewidth = 2,
            gridcolor = "ffff",
            categoryorder = "array",
            categoryarray = x2
        ),
        yaxis = list(
            title = y_title,
            zerolinecolor = "#ffff",
            zerolinewidth = 2,
            gridcolor = "ffff"
        )
    )

print(fig)