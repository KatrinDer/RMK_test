install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lubridate")

library(tidyverse)
library(ggplot2)
library(lubridate)

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

# creating a new table with new data
new_data <- data.frame(leaving_home,Zoo_posix,arr_meeting,late=!arr_on_time)
new_data

#making a plot for leaving home and arriving at the meeting
ggplot(data=new_data)+
  geom_line(aes(x=leaving_home, y=arr_meeting), color=late)+
  geom_point(size=4)+
  geom_hline(yintercept = meeting, linetype=dashed, color= "red")

# will be late
late <- arr_meeting > meeting
  