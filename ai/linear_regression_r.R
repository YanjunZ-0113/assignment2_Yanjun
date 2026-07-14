#!/usr/bin/env Rscript
# Simple linear regression from command-line arguments.

args <- commandArgs(trailingOnly = TRUE)
args_all <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", args_all[grep("^--file=", args_all)])
script_dir <- if (length(script_path)) dirname(normalizePath(script_path)) else getwd()
plot_file <- file.path(script_dir, "linear_regression_r_output.png")

usage <- function() {
  script <- basename(commandArgs(trailingOnly = FALSE)[grep("^--file=", commandArgs(trailingOnly = FALSE))])
  script <- if (length(script)) sub("^--file=", "", script) else "linear_regression_r.R"
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
r2 <- summary(model)$r.squared
rmse <- sqrt(mean(residuals(model)^2))

cat("R Linear Regression Results\n")
cat("===========================\n")
cat(sprintf("File: %s\n", filename))
cat(sprintf("X column: %s\n", x_column))
cat(sprintf("Y column: %s\n", y_column))
cat(sprintf("Observations: %d\n", nrow(data)))
cat(sprintf("Intercept: %.4f\n", intercept))
cat(sprintf("Slope (%s): %.4f\n", x_column, slope))
cat(sprintf("R-squared: %.6f\n", r2))
cat(sprintf("RMSE: %.4f\n", rmse))

x_label <- if (x_column == "YearsExperience") "Years of Experience" else x_column
y_label <- y_column
plot_title <- paste(y_label, "vs", x_label, "with Regression Line")

png(plot_file, width = 840, height = 840, res = 150)
par(mar = c(5, 4, 4, 2) + 0.1)
plot(
  data[[x_column]],
  data[[y_column]],
  xlab = x_label,
  ylab = y_label,
  main = plot_title,
  pch = 19,
  col = "steelblue"
)
abline(model, col = "red", lwd = 2)
legend(
  "topleft",
  legend = c("Observed", "Regression line"),
  col = c("steelblue", "red"),
  pch = c(19, NA),
  lty = c(NA, 1),
  lwd = c(NA, 2)
)
dev.off()

cat(sprintf("Plot saved to %s\n", plot_file))
