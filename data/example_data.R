#' Example dataset for dataInspector package
#'
#' A synthetic dataset containing various data types and issues for demonstration purposes.
#'
#' @format A data frame with 100 rows and 4 variables:
#' \describe{
#'   \item{normal_var}{A numeric variable with normal distribution}
#'   \item{skewed_var}{A numeric variable with right-skewed distribution}
#'   \item{category_var}{A factor variable with categories}
#'   \item{var_with_missing}{A numeric variable with missing values}
#' }
#' @examples
#' data(example_data)
#' report_data(example_data)
"example_data"

# Create the example dataset
set.seed(123)
example_data <- data.frame(
  normal_var = rnorm(100, mean = 50, sd = 10),
  skewed_var = rexp(100, rate = 0.5) + 30,
  category_var = factor(sample(c("A", "B", "C"), 100, replace = TRUE, 
                               prob = c(0.5, 0.3, 0.2))),
  var_with_missing = c(rnorm(90, mean = 100, sd = 15), rep(NA, 10))
)

# Save the dataset
save(example_data, file = "data/example_data.rda")
