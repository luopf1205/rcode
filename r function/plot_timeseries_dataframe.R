library(ggplot2)
library(tidyr)
library(dplyr)

# Function to plot time series data
plot_time_series <- function(data, date_col_name, plot_type = "combined") {
  # Ensure the date column is Date type
  data[[date_col_name]] <- as.Date(data[[date_col_name]])
  
  if (plot_type == "combined") {
    # Dynamically build the plot
    p <- ggplot(data = data, aes_string(x = date_col_name)) +
      labs(title = "Time Series Comparison", x = "Date", y = "Value") +
      theme_minimal()
    
    # Add each time series to the plot
    for (col_name in setdiff(names(data), date_col_name)) {
      p <- p + geom_line(aes_string(y = col_name, colour = col_name))
    }
    
    p <- p + scale_colour_manual(values = rainbow(length(setdiff(names(data), date_col_name))))
    
  } else if (plot_type == "faceted") {
    # Pivot data to long format for faceting
    data_long <- data %>%
      pivot_longer(cols = -all_of(date_col_name), names_to = "series", values_to = "value")
    
    # Create a faceted plot
    p <- ggplot(data = data_long, aes(x = as.Date(data_long[[date_col_name]]), y = value, colour = series)) +
      geom_line() +
      facet_wrap(~series, scales = "free_y") +
      labs(title = "Faceted Time Series Plot", x = "Date", y = "Value") +
      theme_minimal()
  } else {
    stop("Invalid plot_type specified. Use 'combined' or 'faceted'.")
  }
  
  return(p)
}

# Usage example:
# df <- your_dataframe_with_dates_and_series
# plot_combined <- plot_time_series(df, "your_date_column_name", "combined")
# plot_faceted <- plot_time_series(df, "your_date_column_name", "faceted")
# print(plot_combined)
# print(plot_faceted)
