require("plotly")

source("lab12-14/c/ackley.r")

title <- "Porównanie metod"
filename <- "Method"
x_title <- "Metody"
y_title <- "Uśredniona odległość od minimum globalnego"
# Obie funkcje mają minimum w 0 więc wynik jest jednocześnie odległością


file_path <- paste("lab12-14/c/ackley_results/", filename, ".csv", sep = "")
solution_path <- paste(
    "lab12-14/c/ackley_results/",
    filename,
    "_solutions.csv",
    sep = ""
)

df <- read.csv(file_path, header = TRUE)
x <- paste(df[["config_name"]])
y <- round(df[["avg_results"]], digits = 16)
data <- data.frame(x, y)

dfs <- read.csv(solution_path, header = TRUE)
arr_max <- c()
arr_min <- c()
for (i in seq(1, 41, by = 10)) {
    z_max <- round(max(dfs[["z"]][i:(i + 9)]), digits = 16)
    z_min <- round(min(dfs[["z"]][i:(i + 9)]), digits = 16)
    arr_max <- append(arr_max, z_max)
    arr_min <- append(arr_min, z_min)
}

fig <- plot_ly(data,
    x = ~x, y = ~y, type = "bar", text = y,
    textposition = "outside",
    error_y = ~ list(
        type = "data",
        array = arr_max - y,
        arrayminus = y - arr_min,
        color = "#0f3a58aa"
    )
) %>%
    layout(
        title = title,
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

print(fig)