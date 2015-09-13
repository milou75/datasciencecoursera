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

library(dplyr)
########################################################################
## Step 1 - Subset and isolate relevant data (2 days) in a separate dataframe.
########################################################################
FULL_HPC<-read.table("./household_power_consumption.txt", sep=";", header= TRUE, na.strings=c("?"), colClasses=c("character","character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
TWO_DAYS_HPC<-filter(FULL_HPC, ((Date=="1/2/2007")|(Date=="2/2/2007")))

########################################################################
## Step 2 - Add a Comumn for getting clean Date and Time
########################################################################
TWO_DAYS_HPC$Date<-as.Date(TWO_DAYS_HPC$Date, format = "%d/%m/%Y")
TWO_DAYS_HPC<-mutate(TWO_DAYS_HPC, DateTime=paste(TWO_DAYS_HPC$Date, TWO_DAYS_HPC$Time))
TWO_DAYS_HPC$DateTime<-strptime(TWO_DAYS_HPC$DateTime,"%Y-%m-%d %H:%M:%S")

########################################################################
## Step 3 - Prepare Plot 2
########################################################################
plot(TWO_DAYS_HPC$DateTime, TWO_DAYS_HPC$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
## Note : scale "Jeu Ven Sam" on the x axis stands for "Thu      Fri    Sat" in English


########################################################################
## Step 4 - Prepare Output PNG File (480*480)
########################################################################
dev.copy(png, file="./plot2.png")
dev.off()
