pacman::p_load(readr)
pacman::p_load(dplyr)
pacman::p_load(stringr)
pacman::p_load(tidyr)

atemp <- list.files(pattern = ".txt")

for(i in atemp) {
 
 assign(paste0(i, "df"), read_file(i))
 
}

### Might not need all this, figure it out soon
childline.org.uk.txtdf <- as.data.frame(childline.org.uk.txtdf)
cpchalifax.org.uk.txtdf <- as.data.frame(cpchalifax.org.uk.txtdf)
carefreekids.org.txtdf <- as.data.frame(carefreekids.org.txtdf)
healthyyoungmindspennine.nhs.uk.txtdf <- as.data.frame(healthyyoungmindspennine.nhs.uk.txtdf)
interchangesheffield.org.uk.txtdf <- as.data.frame(interchangesheffield.org.uk.txtdf)
kidstimefoundation.org.txtdf <- as.data.frame(kidstimefoundation.org.txtdf)
otrtwickenham.com.txtdf <- as.data.frame(otrtwickenham.com.txtdf)
ymcadlg.org.txtdf <- as.data.frame(ymcadlg.org.txtdf)
psspeople.com.txtdf <- as.data.frame(psspeople.com.txtdf)
middlesbroughandstocktonmind.org.uk.txtdf <- as.data.frame(middlesbroughandstocktonmind.org.uk.txtdf)
swingsandsmiles.co.uk.txtdf <- as.data.frame(swingsandsmiles.co.uk.txtdf)
discvol.org.uk.txtdf <- as.data.frame(discvol.org.uk.txtdf)
ne.org.uk.txtdf <- as.data.frame(ne.org.uk.txtdf)
southendcarers.co.uk.txtdf <- as.data.frame(southendcarers.co.uk.txtdf)
ymcadlg.org.txtdf <- as.data.frame(`disc-ymcadlg.org.txtdf`)
sussexcommunity.org.uk.txtdf <- as.data.frame(sussexcommunity.org.uk.txtdf)
thewishcentre.org.uk.txtdf <- as.data.frame(thewishcentre.org.uk.txtdf)

rm(i, atemp, df_list, `door-ways.co.uk.txtdf`, `disc-vol.org.uk.txtdf`)

df_list <- lapply(ls(), function(x) if (class(get(x)) == "data.frame") get(x))

df <- bind_cols(df_list)### List the rest of the files

rm(df_list)

df <- gather(df, site, parsed_text)

df$parsed_text <- str_replace_all(df$parsed_text, "[\n\r\n\r]" , " ")

df$parsed_text <- str_replace_all(df$parsed_text, "[\t]" , " ")

df$parsed_text <- str_replace_all(df$parsed_text, "\\s+" , " ")

df$incredible <- length(grep("Incredible Years", df$parsed_text, ignore.case = TRUE))

df$coping <- length(grep("Coping Cat", df$parsed_text, ignore.case = TRUE))

df$triplep <- length(grep("Triple P", df$parsed_text, ignore.case = TRUE))

