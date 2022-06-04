require("plotly")
require("dplyr")
require("readr")

# setwd("lab12-14/a/functions_results")
df <- list.files(path = ".", pattern = "*.csv") %>%
    lapply(read_csv) %>%
    bind_rows()

# wszystkie wartosci domyslne
title <- "Porównanie funkcji kombinacji własnych funkcji"
x_title <- "Kombinacja własnych funkcji"
y_title <- "Średnia odleglosc od minimum globalnego"
# # Obie funkcje mają minimum w 0 więc wynik jest jednocześnie odległością

x <- paste(df[["config_name"]])
y <- round(df[["avg_results"]], digits = 5)
data <- data.frame(x, y)

fig <- plot_ly(data,
    x = ~x, y = ~y, type = "bar", text = y,
    textposition = "outside"
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
            gridcolor = "ffff"
        ),
        yaxis = list(
            title = y_title,
            zerolinecolor = "#ffff",
            zerolinewidth = 2,
            gridcolor = "ffff"
        )
    )
print(fig)