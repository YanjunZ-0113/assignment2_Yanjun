#!/usr/bin/env Rscript
# Simple linear model from command-line arguments.

args <- commandArgs(trailingOnly = TRUE)
args_all <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", args_all[grep("^--file=", args_all)])
script_dir <- if (length(script_path)) dirname(normalizePath(script_path)) else getwd()
plot_file <- file.path(script_dir, "regression_plot_r.png")

usage <- function() {
  script <- basename(commandArgs(trailingOnly = FALSE)[grep("^--file=", commandArgs(trailingOnly = FALSE))])
  script <- if (length(script)) sub("^--file=", "", script) else "linear_model.R"
  cat(sprintf("Usage: %s <filename> <x_column> <y_column>\n", script))
  quit(status = 1)
}

if (length(args) != 3) {
  usage()
}

filename <- args[1]
x_column <- args[2]
y_column <- args[3]

if (!file.exists(filename)) {
  cat(sprintf("Error: file not found: %s\n", filename))
  quit(status = 1)
}

data <- read.csv(filename, stringsAsFactors = FALSE)
if (!(x_column %in% names(data)) || !(y_column %in% names(data))) {
  cat(sprintf("Error: columns must exist in %s\n", filename))
  cat(sprintf("Available columns: %s\n", paste(names(data), collapse = ", ")))
  quit(status = 1)
}

formula <- as.formula(paste(y_column, "~", x_column))
model <- lm(formula, data = data)

coefs <- coef(model)
intercept <- unname(coefs[1])
slope <- unname(coefs[2])
pearson_r <- cor(data[[x_column]], data[[y_column]])
mse <- mean(residuals(model)^2)
r2 <- summary(model)$r.squared

cat("R Linear Model Results\n")
cat("========================\n")
cat(sprintf("File: %s\n", filename))
cat(sprintf("X column: %s\n", x_column))
cat(sprintf("Y column: %s\n", y_column))
cat(sprintf("Observations: %d\n", nrow(data)))
cat(sprintf("Slope (%s): %.4f\n", x_column, slope))
cat(sprintf("Intercept: %.4f\n", intercept))
cat(sprintf("Pearson's r: %.6f\n", pearson_r))
cat(sprintf("MSE: %.4f\n", mse))
cat(sprintf("R-squared (optional): %.6f\n", r2))

x_vals <- data[[x_column]]
y_vals <- data[[y_column]]
x_label <- if (x_column == "YearsExperience") "Years of Experience" else x_column
plot_title <- paste(y_column, "vs", x_label, "with Annotated Regression Line")

equation <- sprintf(
  "%s = %s + %s * %s\nPearson's r = %.4f\nMSE = %s\nR² = %.4f",
  y_column,
  format(round(intercept), big.mark = ",", scientific = FALSE),
  format(round(slope), big.mark = ",", scientific = FALSE),
  x_column,
  pearson_r,
  format(round(mse), big.mark = ",", scientific = FALSE),
  r2
)

library(ggplot2)

x_range <- max(x_vals) - min(x_vals)
label_x <- if (x_range > 0) min(x_vals) + 0.05 * x_range else min(x_vals)
label_y <- max(y_vals)

plot <- ggplot(data, aes(x = .data[[x_column]], y = .data[[y_column]])) +
  geom_point(color = "steelblue", size = 3) +
  geom_abline(
    intercept = intercept,
    slope = slope,
    color = "red",
    linewidth = 1
  ) +
  annotate(
    "label",
    x = label_x,
    y = label_y,
    label = equation,
    hjust = 0,
    vjust = 1,
    size = 3.5,
    linewidth = 0.2
  ) +
  labs(
    title = plot_title,
    x = x_label,
    y = y_column
  )

ggsave(plot_file, plot = plot, width = 9, height = 6, dpi = 150)

cat(sprintf("Plot saved to %s\n", plot_file))
