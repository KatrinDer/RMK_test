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
