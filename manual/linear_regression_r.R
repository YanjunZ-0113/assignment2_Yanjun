args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 3) {
  stop("Usage: Rscript linear_regression_r.R <filename> <x_column> <y_column>")
}

filename <- args[1]
x_col <- args[2]
y_col <- args[3]

dataset <- read.csv(filename)
formula <- as.formula(paste(y_col, "~", x_col))
model <- lm(formula, data=dataset)

library(ggplot2)
plot <- ggplot(dataset,aes(x = .data[[x_col]], y = .data[[y_col]])) +
  geom_point(colour = 'blue') +
  geom_smooth(method = "lm",colour = 'green',se = FALSE) +
  ggtitle(paste(y_col,"vs", x_col)) +
  xlab(x_col) +
  ylab(y_col)

ggsave("linear_regression_r_output.png",plot)
print(plot)