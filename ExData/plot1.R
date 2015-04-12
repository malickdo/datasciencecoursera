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
png( "plot1.png", height=480, width=480)
hist( GAP,
      col = "Red",
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency"
)
dev.off()