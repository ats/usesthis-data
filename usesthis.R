# usesthis.R -- run a bunch of numbers on the usesthis data

# -- uncomment and adjust path to set working directory
#setwd("~/data/usesthis-data/")

# -- load in the data
usesthis <- read.table("thesetup-data.txt", sep="\t", comment.char="", quote="", col.names=c("year","month","day","name","gear","usesthis"))

# a bunch of regular expressions to try out
regex.mac <- "macbook|powerbook|mac\\-pro|mac\\-mini|ibook|imac|power\\-mac"
regex.winpcs <- "thinkpad|thinkcentre|inspiron|xps|latitude|precision|aspire|acer|eee\\-pc|elitebook|touchsmart"
regex.winos <- "windows\\-7|windows\\-xp|windows\\-vista"
regex.linux <- "ubuntu|linux|fedora|cygwin"
regex.androids <- "^android|nexus|g1$|droid-2"
regex.consoles <- "wii|ps3|ps3|xbox"
regex.texteditors <- "emacs|textmate|vim|^vi$|bbedit"
regex.nodistraction <- "writeroom|^omm|ia\\-writer"
regex.coffee <- "aws\\-scale|camano|ceramic\\-dripper|chemex|hario|impressa|kenaf|kone|moccamaster|moka|porlex|robur|rocky|super\\-jolly|takahiro|black\\-cat|el\\-pino|la\\-tortuga"

numinterviews <- length(levels(usesthis$name))
apples <- nrow(usesthis[regexpr(regex.mac, usesthis$usesthis, ignore.case=TRUE)!=-1,])
winpcs <- nrow(usesthis[regexpr(regex.winpcs, usesthis$usesthis, ignore.case=TRUE)!=-1,])
windowsOS <- nrow(usesthis[regexpr(regex.winos, usesthis$usesthis, ignore.case=TRUE)!=-1,])
linuxOS <- nrow(usesthis[regexpr(regex.linux, usesthis$usesthis, ignore.case=TRUE)!=-1,])
iphones <- nrow(usesthis[regexpr("iphone", usesthis$usesthis, ignore.case=TRUE)!=-1,])
ipads <- nrow(usesthis[regexpr("ipad", usesthis$usesthis, ignore.case=TRUE)!=-1,])
androids <- nrow(usesthis[regexpr(regex.androids, usesthis$usesthis, ignore.case=TRUE)!=-1,])


numapps.ios <- length(levels(as.factor(as.character(usesthis$usesthis[grep("-ios", usesthis$usesthis)]))))
numapps.android <- length(levels(as.factor(as.character(usesthis$usesthis[grep("-android", usesthis$usesthis)]))))

summary.names <- as.character(summary(usesthis$name, maxsum=11)[1:10])
summary.consoles <- summary(usesthis[regexpr(regex.consoles, usesthis$usesthis, ignore.case=TRUE)!=-1,][6], maxsum=5)
summary.texteditors <- summary(usesthis[regexpr(regex.texteditors, usesthis$usesthis, ignore.case=TRUE)!=-1,][6], maxsum=8)
summary.android <- summary(usesthis[regexpr(regex.androids, usesthis$usesthis, ignore.case=TRUE)!=-1,][6], maxsum=6)[1:5]
summary.nodistraction <- summary(usesthis[regexpr(regex.nodistraction, usesthis$usesthis, ignore.case=TRUE)!=-1,][6], maxsum=5)[1:4]
summary.coffee <- summary(usesthis[regexpr(regex.coffee, usesthis$usesthis, ignore.case=TRUE)!=-1,][6], maxsum=5)[1:4]

# ---------------------------------------------------------------------------
# write a summary file using a series of horribly ugly writeLines and sprintf
# statements; doing this right would involve xtable and then sweave to LaTeX
# to pandoc to markdown, or perhaps something baroque.

outputfile <- file("usesthis-summary.txt", "w")

writeLines("\nTHE SETUP, BY THE NUMBERS\n",outputfile)
writeLines("Data from The Setup, http://usesthis.com/", outputfile)
writeLines("[ https://github.com/waferbaby/usesthis ]", outputfile)
writeLines(sprintf("\n%s interviews", numinterviews),outputfile)
writeLines(sprintf("\nApple PCs:\t%s\nWindows PCs:\t%s", apples, winpcs), outputfile)

writeLines("\nTop 10 Mac models:\n------------------",outputfile)
writeLines(summary(usesthis[regexpr(regex.mac, usesthis$usesthis, ignore.case=TRUE)!=-1,][6],maxsum=11)[1:10],outputfile)

writeLines("\nTop 10 WinPC models:\n--------------------",outputfile)
writeLines(summary(usesthis[regexpr(regex.winpcs, usesthis$usesthis, ignore.case=TRUE)!=-1,][6],maxsum=11)[1:10],outputfile)

# -- Break out windows OS numbers if desired
# writeLines(summary(usesthis[regexpr(regex.winos, usesthis$usesthis, ignore.case=TRUE)!=-1,][4], maxsum=4),outputfile)

writeLines("\nMobile Devices:\n---------------", outputfile)
writeLines(sprintf("iPhones: \t%s\niPads: \t%s", iphones, ipads), outputfile)
writeLines(sprintf("Androids: \t%s", androids), outputfile)

# -- Break out Android phones if desired
# writeLines(sprintf("\nAndroid phones (%i):", androids),outputfile)
# writeLines(          "-------------------",outputfile)
# writeLines(as.character(summary.android),outputfile)

writeLines(sprintf("\niOS apps (unique):\t%s\nAndroid apps (unique):\t%s\n",numapps.ios,numapps.android),outputfile)

writeLines("Top 20 iOS apps by frequency:\n----------------------", outputfile)
writeLines(as.character(summary(usesthis[regexpr("\\-ios$", usesthis$usesthis, ignore.case=TRUE)!=-1,][6],maxsum=21)[1:20]),outputfile)

writeLines("\nGame consoles:\n--------------", outputfile)
writeLines(summary.consoles, outputfile)

writeLines("\nApple vs. Adobe:\n----------------", outputfile)
writeLines(sprintf("Lightroom:\t%s",nrow(usesthis[regexpr("lightroom", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)
writeLines(sprintf("Aperture:\t%s",nrow(usesthis[regexpr("aperture", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)

writeLines("\nText Editor Showdown:",outputfile)
writeLines(  "---------------------",outputfile)
writeLines(summary.texteditors, outputfile)

writeLines("\nText editors (aggregated):",outputfile)
writeLines("--------------------------", outputfile)
writeLines(sprintf("Emacs:\t%s",nrow(usesthis[regexpr("emacs", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)
writeLines(sprintf("Textmate:\t%s",nrow(usesthis[regexpr("textmate", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)
writeLines(sprintf("vi(m):\t%s",nrow(usesthis[regexpr("vim|^vi$", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)
writeLines(sprintf("BBEdit:\t%s",nrow(usesthis[regexpr("bbedit", usesthis$usesthis, ignore.case=TRUE)!=-1,])), outputfile)


writeLines("\n\"Distraction-Free Environments:\"\n--------------------------------", outputfile)
writeLines(summary.nodistraction, outputfile)

writeLines("\nWho names the most stuff (no. of items)?", outputfile)
writeLines("---------------------------------------", outputfile)
for (i in 1:10)
writeLines(paste(row.names(data.frame(summary(usesthis$name)[1:10]))[i],":\t", as.character(summary(usesthis$name)[1:10])[i])
, outputfile)

writeLines("\nCoffee geeks (who names how much coffee gear?):", outputfile)
writeLines("---------------------------------------------", outputfile)
writeLines(summary(as.data.frame(usesthis[regexpr(regex.coffee, usesthis$usesthis, ignore.case=TRUE)!=-1,]$name)), outputfile)

writeLines(sprintf("\n\n\nSummary generated by usesthis.R, %s", date()), outputfile)
writeLines("https://github.com/ats/usesthis-data", outputfile)

close(outputfile)
