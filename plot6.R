library(dplyr)
library(ggplot2)
setwd("~/ExData_Plotting_Project2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
nei <- tbl_df(NEI);scc <- tbl_df(SCC)
rm(NEI);rm(SCC)
scc <- scc[grep("Onroad", scc$Data.Category), ] #All the motor vehicle are belong to Onroad Data.Category, therefore, use Data.Category variable's Onroad type is better than orther variables matching
nei <- inner_join(nei,scc)
motor <- filter(nei, fips == "24510" | fips == "06037")
motor <- group_by(motor, fips, year)
motor <- summarise(motor, emissions = sum(Emissions))
png(filename = "p2plot6linechar.png", bg = "white", width = 740, height = 480)
fipscompare <- ggplot(motor, aes(year, emissions, color = fips))
fipscompare + geom_line()+
        scale_colour_discrete(name = "Country", label = c("Los Angeles","Baltimore"))+
        xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions"))+
        ggtitle("Comparison of Annual Emissions From Motor\n Vehicle Sources between Baltimore and Los Angeles from 1999 to 2008")
dev.off()
