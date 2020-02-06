##This is a script to reorganise the LOTR dataframes to create a nodes df to import into Gephi

setwd("/home/masha/Desktop/M2/Complex_networks/Project/Downloaded_LOTR_csv")

# First I import the dataframes as before:

lotr = read.csv("networks-id-volume1.csv")
#lotr = read.csv("networks-id-volume2.csv")
#lotr = read.csv("networks-id-volume3.csv")

onto = read.csv("ontology.csv", sep = ",") # In this csv, the separator is tabs

# I want to keep each source of interaction once in my dataframe
lotr = as.data.frame(unique(lotr$IdSource))
colnames(lotr) = "id"

lotr$Label = NA #Will contain full labels
lotr$Type = NA
lotr$Importance = NA
lotr$Gender = NA
lotr$Origin = NA

# Defining the labels: using ontology.csv:
for (object in levels(lotr$id))
{
  lotr$Label[lotr$id == object] = as.character(onto$Label[onto$id == object])
}

# Defining the types: using ontology.csv:
for (object in levels(lotr$id))
{
  lotr$Type[lotr$id == object] = as.character(onto$subtype[onto$id == object])
  lotr$Importance[lotr$id == object] = as.character(onto$FreqSum[onto$id == object])
  lotr$Gender[lotr$id == object] = as.character(onto$gender[onto$id == object])
}

# Defining some types by hand:
lotr$Origin[lotr$id == "andu"] = "MiddleEarth"
lotr$Origin[lotr$id == "arag"] = "Gondor"
lotr$Origin[lotr$id == "arat"] = "Gondor"
lotr$Origin[lotr$id == "arwe"] = "Rivendell"
lotr$Origin[lotr$id == "bage"] = "Shire"
lotr$Origin[lotr$id == "bali"] = "Moria"
lotr$Origin[lotr$id == "bilb"] = "Shire"
lotr$Origin[lotr$id == "bill"] = "Shire"
lotr$Origin[lotr$id == "boro"] = "Gondor"
lotr$Origin[lotr$id == "bree"] = "Shire"
lotr$Origin[lotr$id == "cele"] = "Lorien"
lotr$Origin[lotr$id == "comp"] = "MiddleEarth"
lotr$Origin[lotr$id == "dene"] = "Gondor"
lotr$Origin[lotr$id == "dtow"] = "Mordor"
lotr$Origin[lotr$id == "mori"] = "Moria"
lotr$Origin[lotr$id == "duri"] = "Moria"
lotr$Origin[lotr$id == "dwar"] = "MiddleEarth"
lotr$Origin[lotr$id == "edor"] = "Rohan"
lotr$Origin[lotr$id == "elen"] = "Gondor"
lotr$Origin[lotr$id == "elro"] = "Rivendell"
lotr$Origin[lotr$id == "elve"] = "MiddleEarth"
lotr$Origin[lotr$id == "frod"] = "Shire"
lotr$Origin[lotr$id == "gala"] = "Lorien"
lotr$Origin[lotr$id == "ganda"] = "MiddleEarth"
lotr$Origin[lotr$id == "gber"] = "Shire"
lotr$Origin[lotr$id == "gild"] = "MiddleEarth"
lotr$Origin[lotr$id == "gimli"] = "LonelyMountain"
lotr$Origin[lotr$id == "gloi"] = "LonelyMountain"
lotr$Origin[lotr$id == "goll"] = "MiddleEarth"
lotr$Origin[lotr$id == "gond"] = "Gondor"
lotr$Origin[lotr$id == "hald"] = "Lorien"
lotr$Origin[lotr$id == "hobb"] = "Shire"
lotr$Origin[lotr$id == "hton"] = "Shire"
lotr$Origin[lotr$id == "isen"] = "Shire"
lotr$Origin[lotr$id == "isil"] = "Gondor"
lotr$Origin[lotr$id == "lego"] = "Mirkwood"
lotr$Origin[lotr$id == "lori"] = "Lorien"
lotr$Origin[lotr$id == "loth"] = "Lorien"
lotr$Origin[lotr$id == "mdoo"] = "Mordor"
lotr$Origin[lotr$id == "merr"] = "Shire"
lotr$Origin[lotr$id == "mord"] = "Mordor"
lotr$Origin[lotr$id == "morg"] = "Mordor"
lotr$Origin[lotr$id == "nazg"] = "Mordor"
lotr$Origin[lotr$id == "nume"] = "MiddleEarth"
lotr$Origin[lotr$id == "orth"] = "Isengard"
lotr$Origin[lotr$id == "osgi"] = "Gondor"
lotr$Origin[lotr$id == "pipp"] = "Shire"
lotr$Origin[lotr$id == "ring"] = "MiddleEarth"
lotr$Origin[lotr$id == "rive"] = "Rivendell"
lotr$Origin[lotr$id == "roha"] = "Rohan"
lotr$Origin[lotr$id == "sams"] = "Shire"
lotr$Origin[lotr$id == "saru"] = "Isengard"
lotr$Origin[lotr$id == "saur"] = "Mordor"
lotr$Origin[lotr$id == "sfax"] = "Rohan"
lotr$Origin[lotr$id == "shir"] = "Shire"
lotr$Origin[lotr$id == "thor"] = "LonelyMountain"
lotr$Origin[lotr$id == "tiri"] = "Gondor"

##Vol2:
lotr$Origin[lotr$id == "treeb"] = "MiddleEarth"
lotr$Origin[lotr$id == "ents"] = "MiddleEarth"
lotr$Origin[lotr$id == "gorb"] = "MiddleEarth"
lotr$Origin[lotr$id == "shel"] = "MiddleEarth"
lotr$Origin[lotr$id == "fara"] = "Gondor"
lotr$Origin[lotr$id == "eome"] = "Rohan"
lotr$Origin[lotr$id == "grim"] = "Rohan"
lotr$Origin[lotr$id == "eorl"] = "Rohan"
lotr$Origin[lotr$id == "theod"] = "Rohan"
lotr$Origin[lotr$id == "helm"] = "Rohan"
lotr$Origin[lotr$id == "eowy"] = "Rohan"

#Vol3
lotr$Origin[lotr$id == "bere"] = "Gondor"

# I plotted some networks with the importance as a colour code; to this end, I defined intervals to class the characters:
lotr$Importance = as.numeric(lotr$Importance) # First transform Importance into numeric (was character)
lotr$Imp_int = lapply(lotr$Importance, function(x) if ((30<=x)&(x<=200)){x = 1}
       else if ((201<=x)&(x<=800)){x = 2} else {x = 3}) # Next separate into intervals determined by hand


# I decided to remove the places, groups and tertiary characters (keeping 'important' characters essentially):
lotr = lotr[lotr$Type != "Place" & lotr$id != "elve" & lotr$Label != "Dwarves" &
              lotr$id != "arat" & lotr$Label != "Goldberry" & lotr$Label != "Hobbits" & lotr$Type != "Object" &
              lotr$Type != "Animal" & lotr$Label != "Company" & lotr$Label != "Isildur" & lotr$Label != "Elendil" &
              lotr$id != "glorf" & lotr$id != "tomb" & lotr$id != "orcs" & lotr$id != "ents",]

# Finally I am transforming the data back to characters, by column:
lotr = apply(lotr, 2, as.character)
# And creating a dataframe to tidy up:
lotr=as.data.frame(lotr)

# And finally, exporting the dataframe in order to import it into Gephi:
#write.csv(lotr, "nodes_ppl_vol1.csv", row.names = FALSE) # Please uncomment the file you would like to export to
#write.csv(lotr, "nodes_ppl_vol2.csv", row.names = FALSE)
#write.csv(lotr, "nodes_ppl_vol3.csv", row.names = FALSE)