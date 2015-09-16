library(RColorBrewer)

# Import geo files --------------------------------------------------------


load(file="your_path/gadm_new.RDATA")
load(file="your_path/Municipalities.RData")
Zipcode <- read.csv2("your_path/Zipcode.csv")

# show labels
plot(gadm_new)
invisible(text(getSpPPolygonsLabptSlots(gadm_new), labels=as.character(gadm_new$NAME_2), cex=0.2))

# Use str(gadm_new@data, max.level=2) to see content


# Import customer file ----------------------------------------------------


# Customer file name has two columns: first column contains Zipcodes, second column contains Customer count per zipcode
# Customers <- read.csv2(file="Z:/R/DATA/OUTPUT/---CUSTOMER FILE.csv---")

# Get staff file
Customers <- read.csv2(file="your_path/WhatEver.csv")


# Plot Bookit Customers per Municipality ----------------------------------


# Collapse Customer data file
Cust <- aggregate(Customers$Count, by=list(Zipcode=Customers$PP4), FUN=sum, na.rm = TRUE)
colnames(Cust) <- c("Zipcode","Count")
# Add Municipalities to Customer data
Cust1 <- merge(Zipcode,Count, by.x="X4PP", by.y="Zipcode", all.x=TRUE)
# Collapse Customer data file
Cust2 <- aggregate(Cust1$Count, by=list(Municipality=Cust1$Municipality), FUN=sum, na.rm = TRUE)
colnames(Cust2) <- c("Municipality","Count")
# Add ID's
Cust3 <- merge(Municipalities,Cust2, by.x="NAME_2", by.y="Municipality", all.x=TRUE)
# Order the data
Cust4 <- Cust3[order(Cust3$ID_2),]
# Determine min and max values

# Define bins
# Normal bin
Q <- quantile(Cust4$Count, c(0,0.13,0.25,0.37,0.50,0.63,0.75,0.87,1))
Q <- round(Q, digits=0)
print(Q)
col_cust <- as.factor(as.numeric(cut(Cust4$Count,breaks=Q)))
levels(col_cust) <- c(paste(Q[1],"-",Q[2],sep=""),
                      paste(Q[2],"-",Q[3],sep=""),
                      paste(Q[3],"-",Q[4],sep=""),
                      paste(Q[4],"-",Q[5],sep=""),
                      paste(Q[5],"-",Q[6],sep=""),
                      paste(Q[6],"-",Q[7],sep=""),
                      paste(Q[7],"-",Q[8],sep=""),
                      paste(Q[8],"-",Q[9],sep=""))


# Small bin (set manually)
Q <- quantile(Cust4$Count)    # Show output to set next vector Q manually
print(Q)
Q <- c(0,1,2,5,max(Cust4$Customers))
col_cust <- as.factor(as.numeric(cut(Cust4$Count,breaks=Q)))
levels(col_cust) <- c(paste(Q[1],"-",Q[2],sep=""),
                      paste(Q[2],"-",Q[3],sep=""),
                      paste(Q[3],"-",Q[4],sep=""),
                      paste(Q[4],"-",Q[5],sep=""))

# Align gadm with col_no 
gadm_cust <- gadm_new[order(gadm_new$ID_2),]
gadm_cust$col_cust <- col_cust
# Set colors and plot variables
myPaletteCust <- brewer.pal(length(Q)-1,"Spectral")
par.settings <- list(axis.line=list(col=NA),fontsize=list(text=14))
main <- "Staf per Gemeente"
sub <- paste("1 januari 2016   n = ",sum(Cust4$Customers),sep="")


# plot map with colours and save as PNG
png('file=your_path/WhatEver.png',width=1000,height=1250,units="px",bg = "transparent")
spplot(gadm_cust,
       "col_cust",
       col.regions=myPaletteCust,
       col="black",
       lwd=.9,
       colorkey=TRUE,
       main=main,
       sub=sub,
       par.settings=par.settings)
dev.off()


# Close Script ------------------------------------------------------------


# remove obsolete objects
rm(list=ls())
