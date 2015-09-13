########################################################################
## Step 0 - Getting (unzipped) Dataset from server and unzip under working directory
########################################################################
if (file.exists("./DOWNLOADED")){unlink("./DOWNLOADED", recursive=TRUE)}
dir.create("DOWNLOADED")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./DOWNLOADED/household_power_consumption.zip",method="curl")
unzip("./DOWNLOADED/household_power_consumption.zip", exdir=".")
rm(fileUrl)
## Note : DOWNLOADED Directory is left for reference only

########################################################################
## Step 1 - Subset and prepare relevant data (2 days) in a separate dataframe.
########################################################################
FULL_HPC<-read.table("./household_power_consumption.txt", sep=";", header= TRUE, na.strings=c("?"), colClasses=c("character","character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
library(dplyr)
TWO_DAYS_HPC<-filter(FULL_HPC, ((Date=="1/2/2007")|(Date=="2/2/2007")))

########################################################################
## Step 2 - Prepare Plot 1
########################################################################
hist(TWO_DAYS_HPC$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

########################################################################
## Step 3 - Prepare Output PNG File (480*480)
########################################################################
dev.copy(png, file="./plot1.png")
dev.off()
