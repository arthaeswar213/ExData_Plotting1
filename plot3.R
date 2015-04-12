## Reading data from file in Working directory and creating data frame
plot3_df <- read.csv("./household_power_consumption.txt", header=T, sep=';',
                     na.strings="?",check.names=F, stringsAsFactors=F,
                     comment.char="", quote='\"')

## Converting to Date format
plot3_df$Date <- as.Date(plot3_df$Date, format="%d/%m/%Y")

## Subsetting the data - 1st and 2nd feb
plot3_data <- subset(plot3_df, subset=(Date >= "2007-02-01" & 
                                           Date <= "2007-02-02"))

## Deleting the full Data frame created initially
rm(plot3_df)

## Converting dates and ## Adding a new column at the end 
## by concatenating date and time only
datetime <- paste(as.Date(plot3_data$Date), plot3_data$Time)
plot3_data$Datetime <- as.POSIXct(datetime)


png(file="plot3.png",
    width = 480,
    height = 480,
    units="px",
    pointsize = 12)

## Creating Plot 3
with(plot3_data,{plot(Datetime,Sub_metering_1,xlab="",
                     ylab="Energy sub metering",type="l")
    lines(Datetime,Sub_metering_2,col="red")      
    lines(Datetime,Sub_metering_3,col="blue")})

legend("topright",col=c("black","red","blue"),lty=1,lwd=2,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## closing File Device 
dev.off()