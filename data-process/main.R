
###################################################
# PACKAGE INSTALLATION ############################

#packages needed for the analysis
PACKAGES <- c('dplyr', 'stringr', 'jsonlite')

#  Install packages
inst <- match(PACKAGES, .packages(all=TRUE))
need <- which(is.na(inst))
if (length(need) > 0) install.packages(PACKAGES[need])

df <- read.csv2('data/data-source.csv', sep = '\t', encoding = 'UTF-8', stringsAsFactors = FALSE)

# the column 'Rang.2016' contains issues
# a) value ranges instead of a single rank (101-150)
# b) blank value

# solve case b) by replacing empty string with '500' (the
# maximum value present in this column)
df$Rang.2016[df$Rang.2016 == ''] <- '500'

# solve case b) by assigning the mean value of a range
assignMeanRange <- function(value) {
  if(stringr::str_detect(value, "-")) {
    values <- stringr::str_split(value, '-')
    value <- do.call(sum, lapply(values, as.integer)) / 2
  }
  return(value)
}

df <- mutate(df, Rang.2016 = Vectorize(assignMeanRange)(Rang.2016))

# delete unnecessary columns
df <- select(df, -Rang.2015)

# select all columns but the 'COMUE' column and 
# set these columns metric as numbers, as they
# contain metrics
col_selection <- Filter(function(x) x != 'COMUE', colnames(df)) 
df[col_selection] <- lapply(df[col_selection], as.numeric)

# sort by score, as we want to color them
# based on a customposition criteria
df <- arrange(df, -Score.total.2016)

# first 4 in different color, and first
#one highlighted
df <- mutate(df, color = 1)
df[1:4,"color"] <- 2
df[1, "color"] <- 3

# to check the cast has been performed: sapply(df, class)

# force pretty colnames (so it can be consumed in javascript)
colnames(df) <- c('COMUE', 'Alumni', 'Award', 'HiCi', 'N_S', 'PUB', 'PCP', 'Score_total_2016', 'Rang_2016', 'color');


# write final dataset as tsv
write.table(df,
            file='data/dataset.tsv',
            row.names = FALSE,
            sep = '\t')


# write final dataset as json, at viz folder
write(jsonlite::toJSON(df, pretty = TRUE), '../data-viz/dataset.json')
