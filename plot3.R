library(dplyr)
library(lubridate)

# First at all, we read all the data.
data_set <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                       na.strings = "?")

# Now we convert the Date variable to a Date class in R in order to filter the data and
# obtain only the entries which are from 2007-02-01 to 2007-02-02.
# Then we join Date and Time columns in a new column named "datetime".
# And finally, we select all columns except the Date and Time columns.
data_set <- mutate (data_set, Date = dmy (Date)) %>%
            filter (Date >= ymd ("2007-02-01") & Date <= ymd ("2007-02-02")) %>%
            mutate (datetime = ymd_hms(paste (Date, Time))) %>%
            select (-Date, -Time)

# Now we paint the graphic in the png file.
png ("plot3.png", 480, 480)

with (data_set, {
          plot(Sub_metering_1~datetime, type = "n",
               xlab = "", ylab = "Energy sub metering")
          lines(datetime, Sub_metering_1)
          lines(datetime, Sub_metering_2, col = "red")
          lines(datetime, Sub_metering_3, col = "blue")
})
legend ("topright", lty = 1, col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()