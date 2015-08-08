# Required sqldf package
library(sqldf)

# Read data file with filtering for date 1/2/2007 & 2/2/2007
df1 <- read.csv.sql("household_power_consumption.txt", 
                    sql="select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")

# Add a column called "Datetime" with concat functions with Date & Time values
df1$Datetime <- as.POSIXct(strptime(paste(df1$Date,df1$Time),"%d/%m/%Y %H:%M:%S"));


# Open PNG graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# Prepare 2x2 multiple plots
par(mfrow = c(2,2), mar=c(4.5,4.5,3,1) )
# Plot 1st chart
plot(df1$Datetime, df1$Global_active_power, xlab="", ylab = "Global Active Power", type = "l")
# Plot 2nd chart
plot(df1$Datetime, df1$Voltage, xlab="datetime", ylab = "Voltage", type = "l")
# Plot 3rd chart
plot(df1$Datetime, df1$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "l")
lines(x = df1$Datetime, y = df1$Sub_metering_2, col = "red", type = "l");
lines(x = df1$Datetime, y = df1$Sub_metering_3, col = "blue", type = "l");
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),  lwd = c(2,2,2), bty = "n"  )
# Plot 4th chart
plot(df1$Datetime, df1$Global_reactive_power, xlab="datetime", ylab = "Global reactive power", type = "l")

# Close the PNG device
dev.off()
