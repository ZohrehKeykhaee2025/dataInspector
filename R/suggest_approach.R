#' Suggest modeling approach based on data characteristics
#'
#' @param data_report Output from report_data function or a data frame
#' @return Text suggestions for modeling approach
#' @export
#' @examples
#' report <- report_data(iris)
#' suggest_approach(report)
#' @importFrom stats rnorm rexp
NULL
suggest_approach <- function(data_report) {
  # If a data frame is passed, generate report first
  if (is.data.frame(data_report)) {
    data_report <- report_data(data_report)
  }
  
  suggestions <- c()
  
  # Check for missing values
  high_missing <- data_report$missing_values$missing_percentage > 20
  if (any(high_missing)) {
    problematic_cols <- data_report$missing_values$column[high_missing]
    suggestions <- c(suggestions, 
                     paste0("High missing values (>20%) in columns: ", 
                            paste(problematic_cols, collapse = ", "),
                            ". Consider removing these columns or using advanced imputation methods."))
  }
  
  # Analyze numeric columns
  if (length(data_report$numeric_stats) > 0) {
    for (col in names(data_report$numeric_stats)) {
      stats <- data_report$numeric_stats[[col]]
      
      # Check for skewness
      if (abs(stats$skewness) > 1) {
        suggestions <- c(suggestions, 
                         paste0("Column '", col, "' is highly skewed (skewness = ", 
                                round(stats$skewness, 2), 
                                "). Consider applying log transformation before modeling."))
      }
      
      # Check for outliers using kurtosis
      if (abs(stats$kurtosis) > 3) {
        suggestions <- c(suggestions, 
                         paste0("Column '", col, "' has high kurtosis (", 
                                round(stats$kurtosis, 2), 
                                "), suggesting potential outliers. Consider robust statistical methods."))
      }
    }
  }
  
  # Analyze factor columns
  if (length(data_report$factor_stats) > 0) {
    for (col in names(data_report$factor_stats)) {
      n_levels <- data_report$factor_stats[[col]]$n_levels
      
      if (n_levels > 10) {
        suggestions <- c(suggestions, 
                         paste0("Column '", col, "' has many levels (", n_levels, 
                                "). Consider grouping rare levels or using regularization techniques."))
      }
    }
  }
  
  # General suggestions based on data types
  numeric_cols <- sum(sapply(data_report$column_types, function(x) any(x %in% c("numeric", "integer"))))
  factor_cols <- sum(sapply(data_report$column_types, function(x) any(x %in% c("factor", "character"))))
  
  if (numeric_cols > 0 && factor_cols == 0) {
    suggestions <- c(suggestions, 
                     "Your data contains only numeric variables. Linear models or tree-based methods could be appropriate.")
  } else if (factor_cols > 0 && numeric_cols == 0) {
    suggestions <- c(suggestions, 
                     "Your data contains only categorical variables. Consider frequency-based models or encoding schemes.")
  } else if (factor_cols > 0 && numeric_cols > 0) {
    suggestions <- c(suggestions, 
                     "Your data contains both numeric and categorical variables. Generalized linear models or tree-based methods could be appropriate.")
  }
  
  # If no specific issues found
  if (length(suggestions) == 0) {
    suggestions <- "No major data issues detected. Standard modeling approaches should work well."
  }
  
  # Format output
  cat("Data Analysis Suggestions:\n")
  cat("==========================\n\n")
  
  for (i in seq_along(suggestions)) {
    cat(i, ". ", suggestions[i], "\n\n", sep = "")
  }
  
  invisible(suggestions)
}

