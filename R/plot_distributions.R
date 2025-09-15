#' Plot distributions of data columns
#'
#' @param data A data frame
#' @param column Optional specific column name
#' @return ggplot2 visualizations
#' @export
#' @examples
#' plot_distributions(iris)
plot_distributions <- function(data, column = NULL) {
  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }
  
  if (!is.null(column) && !column %in% names(data)) {
    stop("Column not found in data")
  }
  
  # If specific column is requested
  if (!is.null(column)) {
    col_data <- data[[column]]
    
    if (is.numeric(col_data)) {
      p <- ggplot2::ggplot(data, ggplot2::aes_string(x = column)) +
        ggplot2::geom_histogram(fill = "steelblue", color = "white", bins = 30) +
        ggplot2::labs(title = paste("Distribution of", column)) +
        ggplot2::theme_minimal()
      
      return(p)
    } else if (is.factor(col_data) || is.character(col_data)) {
      p <- ggplot2::ggplot(data, ggplot2::aes_string(x = column)) +
        ggplot2::geom_bar(fill = "steelblue") +
        ggplot2::labs(title = paste("Distribution of", column)) +
        ggplot2::theme_minimal() +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
      
      return(p)
    }
  }
  
  # If no specific column, create a list of plots for all columns
  plots <- list()
  
  for (col in names(data)) {
    col_data <- data[[col]]
    
    if (is.numeric(col_data)) {
      p <- ggplot2::ggplot(data, ggplot2::aes_string(x = col)) +
        ggplot2::geom_histogram(fill = "steelblue", color = "white", bins = 30) +
        ggplot2::labs(title = paste("Distribution of", col)) +
        ggplot2::theme_minimal()
    } else if (is.factor(col_data) || is.character(col_data)) {
      p <- ggplot2::ggplot(data, ggplot2::aes_string(x = col)) +
        ggplot2::geom_bar(fill = "steelblue") +
        ggplot2::labs(title = paste("Distribution of", col)) +
        ggplot2::theme_minimal() +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
    } else {
      next  # Skip other data types
    }
    
    plots[[col]] <- p
  }
  
  # Return grid of plots if more than one
  if (length(plots) > 1) {
    do.call(gridExtra::grid.arrange, c(plots, ncol = 2))
  } else if (length(plots) == 1) {
    return(plots[[1]])
  }
  
  invisible(plots)
}
