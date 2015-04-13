# Download the data, unzip, delete zip file
file.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file.dest <- 'power.consumption.zip'
download.file( file.url, file.dest )
source.file <- unzip( file.dest, list = TRUE )$Name
unzip( file.dest )
file.remove( file.dest )
rm(file.url)
rm(file.dest)

# Read the data into R, save, and remove source file
ElecPowerConsumption <- read.table( source.file, header = TRUE, sep = ';', na.strings = '?' )
save( ElecPowerConsumption, file = 'ElecPowerConsumption.RData' )
file.remove( source.file )
rm(source.file)

# Subset the data
ElecPowerConsumption$Date <- as.Date(ElecPowerConsumption$Date, format="%d/%m/%Y")
subset_EPC <- subset(ElecPowerConsumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(ElecPowerConsumption)

## Create column - Combo date & time
datetime <- paste(as.Date(subset_EPC$Date), subset_EPC$Time)
subset_EPC$date.time <- as.POSIXct(datetime)

# Generate Plot & Save to png file
GAP <- as.numeric(subset_EPC$Global_active_power)
png( "plot4.png", height=480, width=480)

par(mfrow=c(2,2))

plot(subset_EPC$date.time, GAP,
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)'
     )

plot(subset_EPC$date.time,subset_EPC$Voltage,
     type='l'
    )

plot(subset_EPC$date.time,subset_EPC$Sub_metering_1,
     type='l',
     xlab='',
     ylab='Energy Sub Metering)'     
    )

lines(subset_EPC$date.time,
      subset_EPC$Sub_metering_2,
      type='l',
      col = 'red'
)

lines(subset_EPC$date.time,
      subset_EPC$Sub_metering_3,
      type='l',
      col = 'blue'
)

legend('topright',
       lty = c(1,1,1),
       col = c('black', 'blue', 'red'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
)

plot(subset_EPC$date.time,subset_EPC$Global_reactive_power,
     type='l'
     )

dev.off()