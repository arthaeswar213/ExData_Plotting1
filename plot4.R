## Reading data from file in Working directory and creating data frame
plot4_df <- read.csv("./household_power_consumption.txt", header=T, sep=';',
                     na.strings="?",check.names=F, stringsAsFactors=F,
                     comment.char="", quote='\"')

## Converting to Date format
plot4_df$Date <- as.Date(plot4_df$Date, format="%d/%m/%Y")

## Subsetting the data - 1st and 2nd feb
plot4_data <- subset(plot4_df, subset=(Date >= "2007-02-01" & 
                                           Date <= "2007-02-02"))

## Deleting the full Data frame created initially
rm(plot4_df)

## Converting dates and ## Adding a new column at the end 
## by concatenating date and time only
datetime <- paste(as.Date(plot4_data$Date), plot4_data$Time)
plot4_data$Datetime <- as.POSIXct(datetime)


png(file="plot4.png",
    width = 480,
    height = 480,
    units="px",
    pointsize = 12)

par(mfrow = c(2,2))
## Creating Plot 4
with(plot4_data,plot(Datetime,Global_active_power,xlab="",
                     ylab="Global Active Power",type="l"))

with(plot4_data,plot(Datetime,Voltage,xlab="datetime",
                     ylab="Voltage",type="l"))

with(plot4_data,{plot(Datetime,Sub_metering_1,xlab="",
                      ylab="Energy sub metering",type="l")
                 lines(Datetime,Sub_metering_2,col="red")      
                 lines(Datetime,Sub_metering_3,col="blue")})

legend("topright",col=c("black","red","blue"),lty=1,lwd=2,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


with(plot4_data,plot(Datetime,Global_reactive_power,xlab="datetime",
                     ylab="Global_reactive_power",type="l"))


## closing File Device 
dev.off()