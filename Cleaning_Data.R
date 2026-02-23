#Install required packages:

install.packages("tidyverse")
install.packages("readxl")
install.packages("lubridate")
install.packages("flexdashboard")
install.packages("shiny")
install.packages("plotly")
install.packages("DT")

#using library

library(readxl)
library(tidyverse)
library(dplyr)

df <- read_excel("D:/Sneha_07/finance-expense-categorization-dataset (1).xlsx")
print(df)

#Convert dates and clean values

library(lubridate)

df <- df %>% mutate(transaction_date = as.Date(transaction_date),
                    month = floor_date(transaction_date,"month"),
                    amount = as.numeric(amount)
                    ) %>% filter(amount > 0)
df

#Remove unnecessary columns (optional)

df <- df %>% select(transaction_date, month, amount, category, subcategory, merchant_name, payment_method)
df

#Create Finance Metrics (KPIs)
#Total Expense

total_expense <- sum(df$amount)
total_expense

#Monthly Spending

monthly_expense <- df %>% group_by(month) %>% summarise(total = sum(amount))
monthly_expense

#Category Spending

category_expense <- df %>% group_by(category) %>% summarise(total = sum(amount)) %>% arrange(desc(total))
category_expense


#Add Income column 

income_data <- data.frame(
  month = unique(df$month),
  income = 30000                  #example monthly salary
)
income_data

#Savings calculation

finance_summary <- left_join(monthly_expense, income_data, by="month") %>%
  mutate(savings = income - total)
finance_summary

