require("plotly")
require("dplyr")
require("readr")

init_wd <- "D:/studia/ioiz/IOiZ"
setwd(init_wd)
setwd("lab12-14/a/functions_results")
df <- list.files(path = ".", pattern = "*.csv") %>%
    lapply(read_csv) %>%
    bind_rows()

setwd("solutions")
df2 <- list.files(path = ".", pattern = "*.csv") %>%
    lapply(read_csv) %>%
    bind_rows()
arr_max <-  round(c(
    max(df2[["z"]][11:20]),
    max(df2[["z"]][1:10]),
    max(df2[["z"]][21:30]),
    max(df2[["z"]][31:40]),
    max(df2[["z"]][71:80]),
    max(df2[["z"]][51:60]),
    max(df2[["z"]][41:50]),
    max(df2[["z"]][61:70])
), digits = 5)
arr_min <- round(c(
    min(df2[["z"]][11:20]),
    min(df2[["z"]][1:10]),
    min(df2[["z"]][21:30]),
    min(df2[["z"]][31:40]),
    min(df2[["z"]][71:80]),
    min(df2[["z"]][51:60]),
    min(df2[["z"]][41:50]),
    min(df2[["z"]][61:70])
), digits = 5)


# wszystkie wartosci domyslne
title <- "Porównanie funkcji kombinacji własnych funkcji"
x_title <- "Kombinacja własnych funkcji"
y_title <- "Uśredniona odleglosc od minimum globalnego"
# # Obie funkcje mają minimum w 0 więc wynik jest jednocześnie odległością

x <- paste(df[["config_name"]])
y <- round(df[["avg_results"]], digits = 5)
data <- data.frame(x, y)

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
setwd(init_wd)