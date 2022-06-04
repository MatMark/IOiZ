require("plotly")

title <- "Wyniki dla berlin52 i eil76 przy różnej liczbie iteracji"
filename <- "Iterations"
x_title <- "Liczba iteracji"
y_title <- "Uśredniona różnica w długości ścieżki względem ścieżki optymalnej w %"

file_path <- paste("lab12-14/b/tsp_results/berlin52_", filename, ".csv", sep = "")

file_path2 <- paste("lab12-14/b/tsp_results/eil76_", filename, ".csv", sep = "")

df <- read.csv(file_path, header = TRUE)
x <- paste(df[["config_name"]])
y <- round(df[["avg_distance_from_optimum"]] / 75.44, digits = 2)
data <- data.frame(x, y)

df2 <- read.csv(file_path2, header = TRUE)
x2 <- paste(df2[["config_name"]])
y2 <- round(df2[["avg_distance_from_optimum"]] / 5.45, digits = 2)

fig <- plot_ly(data,
    x = ~x, y = ~y, type = "bar", text = paste(y, "%"),
    textposition = "outside", name = "berlin52"
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
fig <- fig %>% add_trace(x = ~x2, y = ~y2, name = "eil76", text = paste(y2, "%"))
print(fig)