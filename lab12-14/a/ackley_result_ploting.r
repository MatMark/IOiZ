require("plotly")

title <- "Porównanie funkcji selekcji dla różnych populacji"
# filename <- "Mutation"
# filename <- "Crossover"
filename <- "Population"
x_title <- "Populacja"
y_title <- "Uśredniona odległość od minimum globalnego"
# Obie funkcje mają minimum w 0 więc wynik jest jednocześnie odległością


file_path <- paste("lab12-14/a/ackley_results/", filename, "_default.csv", sep = "")

file_path2 <- paste("lab12-14/a/ackley_results/", filename, "_function.csv", sep = "")

df <- read.csv(file_path, header = TRUE)
x <- paste(df[["config_name"]])
y <- round(df[["avg_results"]], digits = 5)
data <- data.frame(x, y)

df2 <- read.csv(file_path2, header = TRUE)
x2 <- paste(df2[["config_name"]])
y2 <- round(df2[["avg_results"]], digits = 5)

fig <- plot_ly(data,
    x = ~x, y = ~y, type = "bar", text = y,
    textposition = "outside", name = "Domyślna funkcja"
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
fig <- fig %>% add_trace(x = ~x2, y = ~y2, name = "Własna funkcja", text = y2)
print(fig)