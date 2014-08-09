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

plot2 <- function(){
    data <- readData()
    plot(data$DateTime, data$Global_active_power, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
}

save2png(plot2, "plot2.png")