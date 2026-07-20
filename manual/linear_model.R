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

slope <- coef(model)[2]
intercept <- coef(model)[1]
pred <- predict(model)
r <- cor(dataset[[x_col]], dataset[[y_col]])
mse <- mean((dataset[[y_col]] - pred)^2)
cat("Slope:", slope, "\n")
cat("Intercept:", intercept, "\n")
cat("Correlation coefficient:", r, "\n")
cat("Mean Squared Error:", mse, "\n")

library(ggplot2)
plot <- ggplot(dataset,aes(x = .data[[x_col]], y = .data[[y_col]])) +
  geom_point(colour = 'blue') +
  geom_smooth(method = "lm",formula = y ~ x,colour = 'green',se = FALSE) +
  annotate("text", x = 1.5,y = max(dataset[[y_col]]) - 10000,label = paste("y =", round(slope, 2), "x +", round(intercept, 2),"\nr =", round(r,      2),"\nMSE =", round(mse, 2))) +
  ggtitle(paste(y_col,"vs", x_col)) +
  xlab(x_col) +
  ylab(y_col)

ggsave("regression_plot_r.png",plot,width = 7,height = 7, units = "in")