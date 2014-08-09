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

plot3 <- function(){
    data <- readData()
    plot(data$DateTime, data$Sub_metering_1, type="n",
         ylab="Energy sub metering", xlab="")

    with(data, points(DateTime, Sub_metering_1, type="l", col = "black"))
    with(data, points(DateTime, Sub_metering_2, type="l", col = "red"))
    with(data, points(DateTime, Sub_metering_3, type="l", col = "blue"))

    legend("topright", lty=1, col = c("black","red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}

save2png(plot3, "plot3.png")