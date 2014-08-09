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

plot1 <- function(){
    data <- readData()
    hist(data$Global_active_power, col = "red",
         xlab="Global Active Power (kilowatts)", main = "Global Active Power")
}

save2png(plot1, "plot1.png")