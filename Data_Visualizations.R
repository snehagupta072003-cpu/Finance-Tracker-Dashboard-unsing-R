#using library
library(ggplot2)

#Monthly Expense Trend

ggplot(monthly_expense,
       aes(x=month, y=total)) + geom_line() + geom_point() + labs(title="Monthly Expenses Trend")

#Category-wise Spending

ggplot(category_expense,
       aes(x=reorder(category,total), y=total)) + geom_col() + coord_flip()

#Payment Method Analysis

df %>% group_by(payment_method) %>% summarise(total=sum(amount)) %>% 
  ggplot(aes(payment_method,total)) + geom_col()

