###########################
# Set working directory
###########################
setwd("C:/Course/GitHub/ExData_Plotting1")

##################
# Read the data
##################
filename <- "C:/Course/Exploratory/project 1/data/household_power_consumption.txt"
allData <- read.delim2(file=filename, header=TRUE, sep=";")

# Filter the data
dateFilter <- c("1/2/2007", "2/2/2007")
plotData <- allData[which(as.character(allData$Date) %in% dateFilter),]

# Combine Date and Time and convert date type
plotData$DateTime <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S", tz="GMT")
col.NULL <- c("Date", "Time")
plotData[, col.NULL] <- data.frame(sapply(plotData[, col.NULL], function(x) {x <- NULL}))

# Convert factors to numerics 
col.numeric <- names(plotData)
col.numeric <- col.numeric[!col.numeric == "DateTime"]
plotData[, col.numeric] <- data.frame(sapply(plotData[, col.numeric], as.numeric))

# Construct plot 2
plotData$kilo <- plotData[,"Global_active_power"]/1000

with(plotData, plot(plotData$DateTime, plotData$kilo, type="l",
     xlab="", ylab="Global Active Power (kilowatts)", col="blue", ylim=range(0,6)))
dev.copy(png, file="plot2.png")
dev.off()

