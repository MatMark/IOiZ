library(plotly)

filename <- "eil76"
title <- paste("Ścieżka optymalna dla", filename)
file_path <- paste("lab12-14/b/", filename, ".csv", sep = "")

result_filename <- "opt_eil76_545_solutions"
result_file_path <- paste("lab12-14/b/tsp_results/", result_filename, ".csv", sep = "")

df <- read.csv(file_path, header = FALSE)
num <- df[[1]]
X <- df[[2]]
Y <- df[[3]]

data <- data.frame(X, Y)

# kolejnosc wedlug wystepowania w wyniku
# id, x, y
result_df <- read.csv(result_file_path, header = FALSE)
result_num <- result_df[[1]]
result_X <- result_df[[2]]
result_Y <- result_df[[3]]

data <- data.frame(X, Y)

fig <- plot_ly(data, x = ~X, y = ~Y, name = ~num, text = ~num, type = "scatter", mode = "markers")
fig <- fig %>% add_markers()
fig <- fig %>% add_text(textposition = "top right")
fig <- fig %>% add_trace(x = ~result_X, y = ~result_Y, name = "Trasa", mode = "lines", line = list(color = "black", width = 0.5, dash = "dash"))
fig <- fig %>% layout(
    title = title,
    xaxis = list(title = "X"),
    yaxis = list(title = "Y"),
    showlegend = FALSE
)

print(fig)