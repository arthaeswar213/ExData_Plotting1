## Reading data from file in Working directory and creating data frame
plot1_df <- read.csv("./household_power_consumption.txt", header=T, sep=';',
                      na.strings="?",check.names=F, stringsAsFactors=F,
                      comment.char="", quote='\"')

## Converting to Date format
plot1_df$Date <- as.Date(plot1_df$Date, format="%d/%m/%Y")

## Subsetting the data - 1st and 2nd feb
plot1_data <- subset(plot1_df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Deleting the full Data frame created initially
rm(plot1_df)

## Converting dates and Adding a new column at the end 
## by concatenating date and time only
datetime <- paste(as.Date(plot1_data$Date), plot1_data$Time)
plot1_data$Datetime <- as.POSIXct(datetime)

png(file="plot1.png",
    width = 480,
    height = 480,
    units="px")

## Creating Plot 1
hist(plot1_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## closing File Device 
dev.off()