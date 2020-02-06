### This is a script to reorganise the LOTR dataframes
library(ggbiplot) # To plot PCA
  
  
setwd("/home/masha/Desktop/M2/Complex_networks/Project/Downloaded_LOTR_csv")

# First, I import the interactions between the characters/ objects/ places. I have the interactions by volume:



lotr = read.csv("networks-id-volume1.csv") # Please comment the irrelevant file names
#lotr = read.csv("networks-id-volume2.csv")
#lotr = read.csv("networks-id-volume3.csv")
###### GET RID OF THIS? lotr = read.csv("networks-id-3books.csv")
  
# Next, I import the file containing information on the interacting perties:
onto = read.csv("ontology.csv", sep = ",", stringsAsFactors = FALSE)

# lotrpca will contain the data as I will use it for the PCA
lotrpca = as.data.frame(unique(lotr$IdSource))
colnames(lotrpca) = "IdSource"

# The ontology contains some information; I will use that and add more:
lotrpca$Type = NA
lotrpca$Importance = NA
lotrpca$Gender = NA
lotrpca$Origin = NA


# First I define the type, and give each an integer value according to the estimated distance between types:
for (object in levels(lotrpca$IdSource)) # Type
  {
    if (onto$subtype[onto$id == object] == "Ainur")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 2
    }
    if (onto$subtype[onto$id == object] == "Dwarf")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 5   
    }
    if (onto$subtype[onto$id == object] == "Elf")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 3   
    }
    if (onto$subtype[onto$id == object] == "Hobbit")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 6   
    }
    if (onto$subtype[onto$id == object] == "Man")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 7   
    }
    if (onto$subtype[onto$id == object] == "Orc")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 4
    }
    if (onto$subtype[onto$id == object] == "Ent")
    {
      lotrpca$Type[lotrpca$IdSource == object] = 1   
    }
  }

# Next I define the origin as per Table 1:
lotrpca$Origin[lotrpca$IdSource == "andu"] = "1"
lotrpca$Origin[lotrpca$IdSource == "arag"] = "9"
lotrpca$Origin[lotrpca$IdSource == "arat"] = "9"
lotrpca$Origin[lotrpca$IdSource == "arwe"] = "4"
lotrpca$Origin[lotrpca$IdSource == "bage"] = "5"
lotrpca$Origin[lotrpca$IdSource == "bali"] = "11"
lotrpca$Origin[lotrpca$IdSource == "bilb"] = "5"
#lotrpca$Origin[lotrpca$IdSource == "bill"] = "5"
lotrpca$Origin[lotrpca$IdSource == "boro"] = "9"
lotrpca$Origin[lotrpca$IdSource == "bree"] = "5"
lotrpca$Origin[lotrpca$IdSource == "cele"] = "3"
lotrpca$Origin[lotrpca$IdSource == "comp"] = "1"
lotrpca$Origin[lotrpca$IdSource == "dene"] = "9"
lotrpca$Origin[lotrpca$IdSource == "dtow"] = "10"
lotrpca$Origin[lotrpca$IdSource == "duri"] = "7"
lotrpca$Origin[lotrpca$IdSource == "dwar"] = "1"
lotrpca$Origin[lotrpca$IdSource == "edor"] = "8"
lotrpca$Origin[lotrpca$IdSource == "elen"] = "9"
lotrpca$Origin[lotrpca$IdSource == "elro"] = "4"
lotrpca$Origin[lotrpca$IdSource == "elve"] = "1"
lotrpca$Origin[lotrpca$IdSource == "frod"] = "5"
lotrpca$Origin[lotrpca$IdSource == "gala"] = "3"
lotrpca$Origin[lotrpca$IdSource == "ganda"] = "1"
lotrpca$Origin[lotrpca$IdSource == "gber"] = "5"
lotrpca$Origin[lotrpca$IdSource == "gild"] = "1"
lotrpca$Origin[lotrpca$IdSource == "gimli"] = "11"
lotrpca$Origin[lotrpca$IdSource == "gloi"] = "11"
lotrpca$Origin[lotrpca$IdSource == "goll"] = "1"
lotrpca$Origin[lotrpca$IdSource == "gond"] = "9"
lotrpca$Origin[lotrpca$IdSource == "hald"] = "3"
lotrpca$Origin[lotrpca$IdSource == "hobb"] = "5"
lotrpca$Origin[lotrpca$IdSource == "hton"] = "5"
lotrpca$Origin[lotrpca$IdSource == "isen"] = "6"
lotrpca$Origin[lotrpca$IdSource == "isil"] = "9"
lotrpca$Origin[lotrpca$IdSource == "lego"] = "2"
lotrpca$Origin[lotrpca$IdSource == "lori"] = "3"
lotrpca$Origin[lotrpca$IdSource == "loth"] = "3"
lotrpca$Origin[lotrpca$IdSource == "mdoo"] = "10"
lotrpca$Origin[lotrpca$IdSource == "merr"] = "5"
lotrpca$Origin[lotrpca$IdSource == "mord"] = "10"
lotrpca$Origin[lotrpca$IdSource == "morg"] = "10"
lotrpca$Origin[lotrpca$IdSource == "nazg"] = "10"
lotrpca$Origin[lotrpca$IdSource == "nume"] = "1"
lotrpca$Origin[lotrpca$IdSource == "orth"] = "6"
lotrpca$Origin[lotrpca$IdSource == "osgi"] = "9"
lotrpca$Origin[lotrpca$IdSource == "pipp"] = "5"
lotrpca$Origin[lotrpca$IdSource == "ring"] = "1"
lotrpca$Origin[lotrpca$IdSource == "rive"] = "4"
lotrpca$Origin[lotrpca$IdSource == "roha"] = "8"
lotrpca$Origin[lotrpca$IdSource == "sams"] = "5"
lotrpca$Origin[lotrpca$IdSource == "saru"] = "6"
lotrpca$Origin[lotrpca$IdSource == "saur"] = "10"
#lotrpca$Origin[lotrpca$IdSource == "sfax"] = "8"
lotrpca$Origin[lotrpca$IdSource == "shir"] = "5"
lotrpca$Origin[lotrpca$IdSource == "thor"] = "11"
lotrpca$Origin[lotrpca$IdSource == "tiri"] = "9"

##Vol2:
lotrpca$Origin[lotrpca$IdSource == "treeb"] = "1"
lotrpca$Origin[lotrpca$IdSource == "ents"] = "1"
lotrpca$Origin[lotrpca$IdSource == "gorb"] = "10"
lotrpca$Origin[lotrpca$IdSource == "shel"] = "10"
lotrpca$Origin[lotrpca$IdSource == "fara"] = "9"
lotrpca$Origin[lotrpca$IdSource == "eome"] = "8"
lotrpca$Origin[lotrpca$IdSource == "grim"] = "8"
lotrpca$Origin[lotrpca$IdSource == "eorl"] = "8"
lotrpca$Origin[lotrpca$IdSource == "theod"] = "8"
lotrpca$Origin[lotrpca$IdSource == "helm"] = "8"
lotrpca$Origin[lotrpca$IdSource == "eowy"] = "8"
  
#Vol3
lotrpca$Origin[lotrpca$IdSource == "bere"] = "9"
  
# Next, I set the gender to integers:
for (object in levels(lotrpca$IdSource)) # Gender
{
  if (onto$gender[onto$id == object] == "female")
  {
    #print(onto$gender[onto$id == object])
    lotrpca$Gender[lotrpca$IdSource == object] = 1   
  }
  if (onto$gender[onto$id == object] == "male")
  {
    lotrpca$Gender[lotrpca$IdSource == object] = 2
  }
}

# And I define the importance as the frequency a character is mentioned at:
for (object in levels(lotrpca$IdSource)) # Importance
{
  lotrpca$Importance[lotrpca$IdSource == object] = onto$FreqSum[onto$id == object]
}

# In order to make lotrpca easier to read, I will also add the type names corresponding to the integer values:
lotrpca$Type_name = NA
for (object in levels(lotrpca$IdSource))
{
  lotrpca$Type_name[lotrpca$IdSource == object] = as.character(onto$subtype[onto$id == object])
}


lotrpca[,2:5] = apply(lotrpca[,2:5], 2, function(x) as.numeric(x)) # PCA works on numeric
lotrpca = na.omit(lotrpca) # PCA doesn't like NAs

# Now I plot the PCA (please comment relevant line determining the x axis and change the title according to volume):
pca = prcomp(lotrpca[,2:5], scale. = TRUE) # scale. = TRUE is suggested by the function developers, although it is FALSE by default
ggbiplot(pca, groups = lotrpca$Type_name, ellipse = TRUE, obs.scale = 1, var.scale = 1) +
  theme_minimal() +
  ggtitle('PCA of LOTR Volume 1 characters') +
  xlim(-2.5, 3)  # x axis for Volume 1
  #xlim(-3.5, 2) # x axis for volumes 2 and 3


# And I also print the summary per principal component:
# The output for each volume is presented in the Supplementary Data
pca
summary(pca)