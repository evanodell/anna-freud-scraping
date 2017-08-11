pacman::p_load(readr)
pacman::p_load(dplyr)
pacman::p_load(stringr)
pacman::p_load(tidyr)

atemp <- list.files(pattern = ".txt")

for(i in atemp) {
 
 assign(paste0(i, "df"), read_file(i))
 
}

rm(i, atemp)

### Might not need all this, figure it out soon
childline.org.uk.txtdf <- as.data.frame(childline.org.uk.txtdf, stringsAsFactors = FALSE)
cpchalifax.org.uk.txtdf <- as.data.frame(cpchalifax.org.uk.txtdf, stringsAsFactors = FALSE)
healthyyoungmindspennine.nhs.uk.txtdf <- as.data.frame(healthyyoungmindspennine.nhs.uk.txtdf, stringsAsFactors = FALSE)
interchangesheffield.org.uk.txtdf <- as.data.frame(interchangesheffield.org.uk.txtdf, stringsAsFactors = FALSE)
kidstimefoundation.org.txtdf <- as.data.frame(kidstimefoundation.org.txtdf, stringsAsFactors = FALSE)
otrtwickenham.com.txtdf <- as.data.frame(otrtwickenham.com.txtdf, stringsAsFactors = FALSE)
ymcadlg.org.txtdf <- as.data.frame(ymcadlg.org.txtdf, stringsAsFactors = FALSE)
psspeople.com.txtdf <- as.data.frame(psspeople.com.txtdf, stringsAsFactors = FALSE)
middlesbroughandstocktonmind.org.uk.txtdf <- as.data.frame(middlesbroughandstocktonmind.org.uk.txtdf, stringsAsFactors = FALSE)
swingsandsmiles.co.uk.txtdf <- as.data.frame(swingsandsmiles.co.uk.txtdf, stringsAsFactors = FALSE)
discvol.org.uk.txtdf <- as.data.frame(discvol.org.uk.txtdf, stringsAsFactors = FALSE)
ne.org.uk.txtdf <- as.data.frame(ne.org.uk.txtdf, stringsAsFactors = FALSE)
southendcarers.co.uk.txtdf <- as.data.frame(southendcarers.co.uk.txtdf, stringsAsFactors = FALSE)
sussexcommunity.org.uk.txtdf <- as.data.frame(sussexcommunity.org.uk.txtdf, stringsAsFactors = FALSE)
thewishcentre.org.uk.txtdf <- as.data.frame(thewishcentre.org.uk.txtdf, stringsAsFactors = FALSE)

df_list <- lapply(ls(), function(x) if (class(get(x)) == "data.frame") get(x))

df <- bind_cols(df_list)### List the rest of the files

rm(df_list)

df <- gather(df, site, parsed_text)

df$parsed_text <- str_replace_all(df$parsed_text, "[\n\r\n\r]" , " ")

df$parsed_text <- str_replace_all(df$parsed_text, "[\t]" , " ")

df$parsed_text <- str_replace_all(df$parsed_text, "\\s+" , " ")

df$mental_health <- lengths(regmatches(df$parsed_text, gregexpr("mental health", df$parsed_text, ignore.case = TRUE)))

df$mental_health

df$incredible <- lengths(regmatches(df$parsed_text, gregexpr("incredible years", df$parsed_text, ignore.case = TRUE)))

df$incredible 

df$coping <- lengths(regmatches(df$parsed_text, gregexpr("coping cat", df$parsed_text, ignore.case = TRUE)))

df$coping

df$triplep <- lengths(regmatches(df$parsed_text, gregexpr("triple p", df$parsed_text, ignore.case = TRUE)))

df$triplep

summary_table <- df[c(1,3:6)]

summary_table

write_csv(summary_table, "summary-table.csv")
