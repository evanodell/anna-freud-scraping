pacman::p_load(readr)
pacman::p_load(dplyr)
pacman::p_load(stringr)


atemp <- list.files(pattern = ".txt")

#search_list <- sapply(atemp, read_file)

#list = list(length(atemp))

for(i in atemp) {
 
 assign(paste0(i, df), read_file(i))
 
}

df_list <- lapply(ls(), function(x) if (class(get(x)) == "list") get(x))

df_list <- lapply(df_list, as.data.frame)

### Might not need all this, figure it out soon
clivey.co.uk.txtdf <- as.data.frame(clivey.co.uk.txtdf)
cpchalifax.org.uk.txtdf <- as.data.frame(cpchalifax.org.uk.txtdf)
carefreekids.org.txtdf <- as.data.frame(carefreekids.org.txtdf)
healthyyoungmindspennine.nhs.uk.txtdf <- as.data.frame(healthyyoungmindspennine.nhs.uk.txtdf)
interchangesheffield.org.uk.txtdf <- as.data.frame(interchangesheffield.org.uk.txtdf)
kidscape.org.uk.txtdf <- as.data.frame(kidscape.org.uk.txtdf)
kidstimefoundation.org.txtdf <- as.data.frame(kidstimefoundation.org.txtdf)
otrtwickenham.com.txtdf <- as.data.frame(otrtwickenham.com.txtdf)
place2be.org.uk.txtdf <- as.data.frame(place2be.org.uk.txtdf)
psspeople.com.txtdf <- as.data.frame(psspeople.com.txtdf)
spurgeonsyc.org.txtdf <- as.data.frame(spurgeonsyc.org.txtdf)
swingsandsmiles.co.uk.txtdf <- as.data.frame(swingsandsmiles.co.uk.txtdf)
welldoing.org.txtdf <- as.data.frame(welldoing.org.txtdf)
ne.org.uk.txt <- as.data.frame(ne.org.uk.txt)

rm(i, atemp)

df_list <- lapply(ls(), function(x) if (class(get(x)) == "data.frame") get(x))

df <- bind_cols(df_list)### List the rest of the files

#rm(df_list)

df <- gather(df, site, parsed_text)

df$parsed_text <- str_replace_all(df$parsed_text, "[\n\r\n\r]" , " ")

df$parsed_text <- str_replace_all(df$parsed_text, "[\t]" , " ")



