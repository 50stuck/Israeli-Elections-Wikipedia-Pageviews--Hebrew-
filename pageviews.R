library(RJSONIO)
library(RCurl)
library(ggplot2)

page <- c("%D7%94%D7%9C%D7%99%D7%9B%D7%95%D7%93", #הליכוד
        "%D7%94%D7%9E%D7%97%D7%A0%D7%94%20%D7%94%D7%A6%D7%99%D7%95%D7%A0%D7%99", #המחנה הציוני
        "%D7%94%D7%91%D7%99%D7%AA%20%D7%94%D7%99%D7%94%D7%95%D7%93%D7%99", #הבית היהודי
        "%D7%99%D7%A9%20%D7%A2%D7%AA%D7%99%D7%93", #יש עתיד
        "%D7%99%D7%A9%D7%A8%D7%90%D7%9C%20%D7%91%D7%99%D7%AA%D7%A0%D7%95", #ישראל ביתנו
        "%D7%9B%D7%95%D7%9C%D7%A0%D7%95_%D7%91%D7%A8%D7%90%D7%A9%D7%95%D7%AA_%D7%9E%D7%A9%D7%94_%D7%9B%D7%97%D7%9C%D7%95%D7%9F", #כולנו כחלון
        "%D7%9E%D7%A8%D7%A6") #מרצ

plotofwiki <- ggplot() + scale_x_datetime() + xlab("") + ylab("צפיות") +labs(title="צפיות בערכי ויקיפדיה")

for (i in 1:length(page)){
        
raw_data <- getURL(paste("http://stats.grok.se/json/he/latest90/", page[i], sep=""))
data <- fromJSON(raw_data)
views <- data.frame(timestamp=paste(names(data$daily_views), " 12:00:00", sep=""), stringsAsFactors=F)
views$count <- data$daily_views
views$timestamp <- as.POSIXlt(views$timestamp) # Transform to POSIX datetime
views <- views[order(views$timestamp),]

plotofwiki <- plotofwiki + geom_line(data=views, aes(timestamp, count, colour=i), colour=i)
}

plotofwiki