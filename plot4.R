readData <- function(){
    csv <- read.csv("household_power_consumption.txt", sep = ";",
                    colClasses=c(rep("character", 2), rep("numeric", 7))
                    , na.strings="?")

    csv_subset <- csv[csv$Date == "1/2/2007" | csv$Date == "2/2/2007", ]

    csv_subset$DateTime <- strptime(paste(csv_subset$Date, csv_subset$Time),
                                    "%d/%m/%Y %H:%M:%S")
    csv_subset
}

openDevice <- function(name){
    png(filename = name, width = 480, height = 480, units = "px",
        bg = "transparent", type = "cairo")
}

closeDevice <- function(){
    dev.off()
}

save2png <- function(plotfunction, name){
    openDevice(name)
    plotfunction()
    closeDevice()
}

plot4 <- function(){
    data <- readData()

    par(mfrow = c(2, 2))

    plot(data$DateTime, data$Global_active_power, type="l",
         ylab="Global Active Power", xlab="")

    plot(data$DateTime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

    plot(data$DateTime, data$Sub_metering_1, type="n",
         ylab="Energy sub metering", xlab="")
    with(data, points(DateTime, Sub_metering_1, type="l", col = "black"))
    with(data, points(DateTime, Sub_metering_2, type="l", col = "red"))
    with(data, points(DateTime, Sub_metering_3, type="l", col = "blue"))
    legend("topright", lty=1, col = c("black","red", "blue"), bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    plot(data$DateTime, data$Global_reactive_power, type="l",
         ylab="Global_reactive_power", xlab="datetime")
}

save2png(plot4, "plot4.png")