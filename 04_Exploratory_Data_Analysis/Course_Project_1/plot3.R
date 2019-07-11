# Download and unzip file if it does not exist
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"

if (!file.exists(zipfile)) {
  download.file(zipURL, zipfile, method = "curl")
}

dataset.name <- "household_power_consumption"
if (!file.exists(dataset.name)) {
  unzip(zipfile)
}

# Read data
hpc_data <- read.table("household_power_consumption.txt", 
                       header = TRUE, 
                       sep = ";", 
                       stringsAsFactors = FALSE,
                       na.strings = "?")

# Convert date and time variables to date/time classes and reformat them
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
hpc_data$Time <- format(strptime(hpc_data$Time, "%H:%M:%S"),"%H:%M:%S")
hpc_data$datetime <- as.POSIXct(strptime(paste(hpc_data$Date, hpc_data$Time), "%Y-%m-%d %H:%M:%S"))

#Subset data only to observations from dates 2007-02-01 and 2007-02-02
hpc_data <- subset(hpc_data, subset = (Date == "2007-02-01" | Date == "2007-02-02"))

# Plot 3
png("plot3.png", width=480, height=480)
plot(hpc_data$Sub_metering_1 ~ hpc_data$datetime,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(hpc_data$Sub_metering_2 ~ hpc_data$datetime,
      col = "red")
lines(hpc_data$Sub_metering_3 ~ hpc_data$datetime,
      col = "blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = "2")
dev.off()