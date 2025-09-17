#' Generate comprehensive data report
#'
#' @param data A data frame
#' @return A list with comprehensive data summary
#' @export
#' @examples
#' report_data(iris)
report_data <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }
  
  # Basic overview
  overview <- list(
    n_rows = nrow(data),
    n_cols = ncol(data),
    memory_size = format(utils::object.size(data), units = "auto")
  )
  
  # Missing values analysis
  missing_summary <- sapply(data, function(x) {
    sum(is.na(x))
  })
  
  missing_percentage <- sapply(data, function(x) {
    round(sum(is.na(x)) / length(x) * 100, 2)
  })
  
  # Column types
  col_types <- sapply(data, class)
  
  # Numeric columns analysis
  numeric_stats <- list()
  numeric_cols <- sapply(data, is.numeric)
  
  if (any(numeric_cols)) {
    numeric_data <- data[, numeric_cols, drop = FALSE]
    
    numeric_stats <- lapply(numeric_data, function(x) {
      list(
        mean = mean(x, na.rm = TRUE),
        median = median(x, na.rm = TRUE),
        sd = sd(x, na.rm = TRUE),
        q1 = quantile(x, 0.25, na.rm = TRUE),
        q3 = quantile(x, 0.75, na.rm = TRUE),
        skewness = moments::skewness(x, na.rm = TRUE),
        kurtosis = moments::kurtosis(x, na.rm = TRUE)
      )
    })
  }
  
  # Factor columns analysis
  factor_stats <- list()
  factor_cols <- sapply(data, is.factor)
  
  if (any(factor_cols)) {
    factor_data <- data[, factor_cols, drop = FALSE]
    
    factor_stats <- lapply(factor_data, function(x) {
      list(
        levels = levels(x),
        n_levels = length(levels(x)),
        counts = table(x)
      )
    })
  }
  
  # Prepare final result
  result <- list(
    overview = overview,
    missing_values = data.frame(
      column = names(data),
      missing_count = missing_summary,
      missing_percentage = missing_percentage,
      row.names = NULL
    ),
    column_types = col_types,
    numeric_stats = numeric_stats,
    factor_stats = factor_stats
  )
  
  class(result) <- "data_report"
  return(result)
}

#' Print method for data_report objects
#' @export
print.data_report <- function(x, ...) {
  cat("Comprehensive Data Report\n")
  cat("=========================\n\n")
  
  cat("Overview:\n")
  cat("- Number of rows:", x$overview$n_rows, "\n")
  cat("- Number of columns:", x$overview$n_cols, "\n")
  cat("- Memory size:", x$overview$memory_size, "\n\n")
  
  cat("Missing Values Summary:\n")
  print(x$missing_values, row.names = FALSE)
  cat("\n")
  
  cat("Column Types:\n")
  print(x$column_types)
  cat("\n")
  
  if (length(x$numeric_stats) > 0) {
    cat("Numeric Columns Statistics:\n")
    for (col in names(x$numeric_stats)) {
      cat("-", col, ":\n")
      cat("  Mean:", x$numeric_stats[[col]]$mean, "\n")
      cat("  Median:", x$numeric_stats[[col]]$median, "\n")
      cat("  SD:", x$numeric_stats[[col]]$sd, "\n")
      cat("  Skewness:", x$numeric_stats[[col]]$skewness, "\n")
      cat("  Kurtosis:", x$numeric_stats[[col]]$kurtosis, "\n\n")
    }
  }
  
  invisible(x)
}
#' @importFrom moments skewness kurtosis
#' @importFrom stats median sd quantile
NULL
