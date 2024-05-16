
library(dplyr)

# Function to index time series columns in a DataFrame
index_ts <- function(data, date_col, base_date) {
  # Ensure that the date column is of type Date
  data[[date_col]] <- as.Date(data[[date_col]])
  base_date <- as.Date(base_date)
  
  # Capture the base values for each series at the base date
  base_values <- data %>% 
    filter(.[[date_col]] == base_date) %>% 
    select(-all_of(date_col)) %>%
    unlist()  # Convert to a vector for easier division
  
  # Index all series relative to the base values
  data %>% 
    mutate(across(-all_of(date_col), ~ . / base_values[cur_column()] * 100))
}

# Example: How to apply this function will be explained, assuming you have a DataFrame 'df'.
# Assuming 'df' is your DataFrame with the first column as dates.
# Example call to the function:
---------------------------------------------
# base_date <- "2020-01-01"  # Specify your base date
#df_indexed <- index_series(df, 'dates', base_date)

# You can then view or further process `df_indexed`
#print(df_indexed)
  ---------------------------------------------
#   library(readxl)
# erate <- read_excel("D:/GitHub/rcode/data sample/exchange_rate.xlsx",
#                     sheet = "erate_monthly")
# 
# 
# 
# head(erate)
# 
# 
# # Assuming 'df' is your DataFrame with the first column as dates.
# # Example call to the function:
# base_date <- "2019-12-31"  # Specify your base date
# erate_indexed <- index_ts(erate, 'dates', base_date)
# # You can then view or further process `df_indexed`
# 
# #plotting the indexed time series
# library(xts)
# library(ggfortify)
# df <- erate_indexed %>% select(-Brunei,-Laos,-Myanmar,Cambodia)
# erate_xts <-  xts(df[,-1], order.by = df$dates)
# autoplot(erate_xts,facets  = FALSE)
-------------------------------------------------------