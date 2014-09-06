library(ggplot2)
library(dplyr)
setwd("~/ExData_Plotting_Project2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
nei <- tbl_df(NEI);scc <- tbl_df(SCC)
rm(NEI);rm(SCC)
scc <- scc[grep("[Cc]oal", scc$SCC.Level.Three), ]
nei <- inner_join(nei, scc)
scc.coal <- group_by(nei, year)
scc.coal <- summarise(scc.coal, emissions = sum(Emissions))
#linechart output
png(filename = "p2plot4linechar.png", bg = "white", width = 480, height = 480)
plot(scc.coal$year, scc.coal$emissions,col = "black",type = "l", xlab = "Year", ylab = expression('Total PM'[2.5]*" Emission (tones)"), main = "Coal Combustion Emissions in the US from 1999 to 2008")
dev.off()
#bar char output
png(filename = "p2plot4barchar.png", bg = "white", width = 480, height = 480)
barplot(scc.coal$emissions,col = "232",ylim = c(0,887180),names.arg=c("1999","2002","2005","2008"),xlab = "Year", ylab = expression('Total PM'[2.5]*" Emission"), main = "Coal Combustion Emissions in the US from 1999 to 2008")
dev.off()