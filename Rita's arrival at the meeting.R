# install packeges one by one
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("scales")

library(tidyverse)
library(ggplot2)
library(lubridate)
library(scales)

# Compiling a table with bus times
Zoo <- c("08:05", "08:16", "08:28", "08:38", "08:48", "08:59") # departure from Zoo stop
Toompark <- c("08:18", "08:30", "08:41", "08:51", "09:01", "09:21") # arrival at Toompargi stop
bus_times <- data.frame(Zoo,Toompark)
head(bus_times)

# changing the times suitable for calculation
Zoo_posix <- as.POSIXct(Zoo, format="%H:%M")
Toompark_posix <- as.POSIXct(Toompark, format="%H:%M")

# start of the meeting
meeting <- as.POSIXct("09:05", format="%H:%M")

# calculating the time to leave home
leaving_home <- Zoo_posix - 300

# calculating the time to arrive at a meeting
arr_meeting <- Toompark_posix + 240

# will arrive on time?
arr_on_time <- arr_meeting <= meeting

# will be late
late <- arr_meeting > meeting

# creating a new table with new data
new_data <- data.frame(leaving_home,Zoo_posix,arr_meeting,late=!arr_on_time)
new_data

# create a binary column where 1 = late and 0 = not late
new_data$late <- as.integer(new_data$arr_meeting > meeting) 

# change time to numeric
new_data$leaving_num <- as.numeric(new_data$leaving_home)

# logistic regression to model the probability of late = 1 (being late)
model <- glm(late ~ leaving_home, data = new_data, family = "binomial")

# predict the probability of being late
new_data$prob_late <- predict(model, type = "response")

#making a plot for being late depending time when leaving home
ggplot(new_data, aes(x = leaving_home)) +
  geom_line(aes(y = prob_late), color = "blue", linewidth = 1.2) +           # logistic curve
  labs(x = "leaving home", y = "probably late", 
       title = "The probability that Rita will be late due to the time she leaves home" )+
  scale_x_datetime(date_labels = "%H:%M", date_breaks = "5 min")
 
#summary, being late or not
late_or_not <- data.frame(leaving_home,Zoo_posix,arr_meeting,being_late=late)
late_or_not

#conclusion
# If Rita leaves home at 8:43, she will probably arrive at the meeting on time.

#recommendation
# Leave home 08:43 or earlier otherwise you may be late