# Required sqldf package
library(sqldf)

# Read data file with filtering for date 1/2/2007 & 2/2/2007
df1 <- read.csv.sql("household_power_consumption.txt", 
                    sql="select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")

# Add a column called "Datetime" with concat functions with Date & Time values
df1$Datetime <- as.POSIXct(strptime(paste(df1$Date,df1$Time),"%d/%m/%Y %H:%M:%S"));


# Open PNG graphics device
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

# Plot time series chart for Global_active_power
plot(df1$Datetime, df1$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type = "l")

# Close the PNG device
dev.off()
