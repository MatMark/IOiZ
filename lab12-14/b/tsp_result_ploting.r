require("plotly")

title <- "Wyniki dla berlin52 i eil76 przy różnej liczbie iteracji"
filename <- "Iterations"
x_title <- "Liczba iteracji"
y_title <- "Uśredniona różnica w dł. ścieżki względem ścieżki optymalnej w %"

file_path <- paste("lab12-14/b/tsp_results/berlin52_", filename, ".csv", sep = "")

file_path2 <- paste("lab12-14/b/tsp_results/eil76_", filename, ".csv", sep = "")

df <- read.csv(file_path, header = TRUE)
x <- paste(df[["config_name"]])
y <- round(df[["avg_distance_from_optimum"]] / 75.44, digits = 2)
data <- data.frame(x, y)

df2 <- read.csv(file_path2, header = TRUE)
x2 <- paste(df2[["config_name"]])
y2 <- round(df2[["avg_distance_from_optimum"]] / 5.45, digits = 2)

solution_path <- paste(
    "lab12-14/b/tsp_results/berlin52_",
    filename,
    "_solutions.csv",
    sep = ""
)

solution_path2 <- paste(
    "lab12-14//b/tsp_results/eil76_",
    filename,
    "_solutions.csv",
    sep = ""
)

dfs <- read.csv(solution_path, header = TRUE)
dfs2 <- read.csv(solution_path2, header = TRUE)
arr_max <- c()
arr_min <- c()
arr_max2 <- c()
arr_min2 <- c()
for (i in seq(1, 41, by = 10)) {
    z_max <- round((max(dfs[["distance_from_optimum"]][i:(i + 9)]) / 75.44), digits = 5)
    z_min <- round((min(dfs[["distance_from_optimum"]][i:(i + 9)]) / 75.44), digits = 5)
    arr_max <- append(arr_max, z_max)
    arr_min <- append(arr_min, z_min)

    z_max2 <- round((max(dfs2[["distance_from_optimum"]][i:(i + 9)]) / 5.45), digits = 5)
    z_min2 <- round((min(dfs2[["distance_from_optimum"]][i:(i + 9)]) / 5.45), digits = 5)
    arr_max2 <- append(arr_max2, z_max2)
    arr_min2 <- append(arr_min2, z_min2)
}

fig <- plot_ly(data,
    x = ~x, y = ~y, type = "bar", text = paste(y, "%"),
    textposition = "outside", name = "berlin52",
    error_y = ~ list(
        type = "data",
        array = arr_max - y,
        arrayminus = y - arr_min,
        color = "#0f3a58aa"
    )
) %>%
    layout(
        title = title,
        legend = list(orientation = "h"),
        plot_bgcolor = "#e5ecf6",
        xaxis = list(
            autotypenumbers = "strict",
            title = x_title,
            zerolinecolor = "#ffff",
            zerolinewidth = 2,
            gridcolor = "ffff",
            categoryorder = "array",
            categoryarray = x
        ),
        yaxis = list(
            title = y_title,
            zerolinecolor = "#ffff",
            zerolinewidth = 2,
            gridcolor = "ffff"
        )
    )
fig <- fig %>% add_trace(
    x = ~x2, y = ~y2, name = "eil76", text = paste(y2, "%"),
    error_y = ~ list(
        type = "data",
        array = arr_max2 - y2,
        arrayminus = y2 - arr_min2,
        color = "#914809aa"
    )
)
print(fig)