#### Creating a 4 plots, 2x2 ####

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

#### Transforming Date and Time (characters) to objects Date and POSIXlt ####
sub_hpc$Date <- as.Date(sub_hpc$Date, format = "%d/%m/%Y")
sub_hpc$Time <- strptime(sub_hpc$Time, format = "%H:%M:%S")
sub_hpc[1:1440, "Time"] <- format(sub_hpc[1:1440, "Time"], "2007-02-01 %H:%M:%S")
sub_hpc[1441:2880, "Time"] <- format(sub_hpc[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

#### Creating a composite plot of 4 graphs ####
png("Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#### Plot 1 (top left) ####
with(sub_hpc,{
     plot(sub_hpc$Time, as.numeric(as.character(sub_hpc$Global_active_power)),
          type = "l", xlab = "", ylab = "Global Active Power")

#### Plot 2 (top right) ####
     plot(sub_hpc$Time, as.numeric(as.character(sub_hpc$Voltage)), 
          type = "l", xlab = "datetime", ylab = "Voltage")

#### Plot 3 (bottom left) ####
     plot(sub_hpc$Time, sub_hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
     with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_1)), col = "black"))
     with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_2)), col="red"))
     with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_3)), col="blue"))
     legend("topright", lty = c(1, 1), col = c("black", "red", "blue"),
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, bty = "n")

#### Plot 4 (bottom right) ####
     plot(sub_hpc$Time, as.numeric(as.character(sub_hpc$Global_reactive_power)),
          type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()