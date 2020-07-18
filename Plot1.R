#### Creating a histogram plot for Global Active Power ####

#### Reading txt file ####
hpc <- read.table("household_power_consumption.txt", skip = 1, sep = ";")

#### Naming ####
names(hpc) <- c("Date", 
                "Time", 
                "Global_active_power", 
                "Global_reactive_power",
                "Voltage", 
                "Global_intensity", 
                "Sub_metering_1", 
                "Sub_metering_2", 
                "Sub_metering_3")

#### Subsetting ####
sub_hpc <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")

#### Histogram ####
png("Plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(sub_hpc$Global_active_power)), 
                             main = "Global Active Power", 
                             xlab = "Global Active Power (kilowatts)", 
                             ylab = "Frequency", 
                             col = "Red")
dev.off()