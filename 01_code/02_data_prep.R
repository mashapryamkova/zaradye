# load data

library(RJSONIO)
library(RCurl)
library(httr)

# grab the data
raw_data <- getURL("https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454")

test <- content(GET("https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454"))

test <- getURL("https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454")

# Then covert from JSON into a list in R
data <- fromJSON(raw_data)
length(data)
# We can coerce this to a data.frame
final_data <- do.call(rbind, data)
# Then write it to a flat csv file
write.csv(final_data, "final_data.csv")



url <- "https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454"
temp <- tempfile()
download.file(url, temp)
download.file("https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454", destfile = "zaradye.zip")
unzip("zaradye.zip")

temp_zip <- paste(temp, ".zip", sep = "")
# unzip(temp)
unzip(temp_zip, "data-102742-2021-08-04.csv")
# note that here I modified your original read.table() which did not work
mydata <- read.csv("data-102742-2021-08-04.csv")
unlink(temp)

library(jsonlite)
mydata <- fromJSON("https://op.mos.ru/EHDWSREST/catalog/export/get?id=1178454")

