## Reading data from file in Working directory and creating data frame
plot2_df <- read.csv("./household_power_consumption.txt", header=T, sep=';',
                     na.strings="?",check.names=F, stringsAsFactors=F,
                     comment.char="", quote='\"')

## Converting to Date format
plot2_df$Date <- as.Date(plot2_df$Date, format="%d/%m/%Y")

## Subsetting the data - 1st and 2nd feb
plot2_data <- subset(plot2_df, subset=(Date >= "2007-02-01" & 
                                           Date <= "2007-02-02"))

## Deleting the full Data frame created initially
rm(plot2_df)

## Converting dates and Adding a new column at the end 
## by concatenating date and time only
datetime <- paste(as.Date(plot2_data$Date), plot2_data$Time)
plot2_data$Datetime <- as.POSIXct(datetime)


png(file="plot2.png",
    width = 480,
    height = 480,
    units="px")

## Creating Plot 2
with(plot2_data,plot(Datetime,Global_active_power,xlab="",
                     ylab="Global Active Power(kilowatts)",type="l"))
     

## closing File Device 
dev.off()