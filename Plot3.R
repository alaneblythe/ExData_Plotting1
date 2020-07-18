#### Creating a basic plot for Energy Sub Metering vs. Time ####

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

#### Basic plot ####
png("Plot3.png", width = 480, height = 480)
plot(sub_hpc$Time, sub_hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_1)), col = "black"))
with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(sub_hpc, lines(Time, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty = c(1, 1), lwd = c(1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()