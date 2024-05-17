
# calculate the difference between each column and a reference column in a data frame
# usage: calculate interest rate differential or other country differential indicator


library(dplyr)

# Function to subtract a reference column's values from all other numeric columns
substract_ref_col <- function(data, date_col_name, ref_col_name) {
  # Validate that the reference column exists in the data
  if (!ref_col_name %in% names(data)) {
    stop("Reference column does not exist in the DataFrame.")
  }
  
  # Subtract reference column values from all other numeric columns
  data %>%
    mutate(across(-all_of(c(date_col_name, ref_col_name)), ~ . - data[[ref_col_name]])) %>%
    select(-all_of(ref_col_name))  # Optionally drop the reference column from the result
}

# Example usage:
# df_adjusted <- create_adjusted_df(df, "your_date_column_name", "your_reference_column_name")
# print(df_adjusted)


