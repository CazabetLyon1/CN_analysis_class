# This script is to plot the interactions by type of character

library(ggplot2)

setwd("/home/masha/Desktop/M2/Complex_networks/Project/Downloaded_LOTR_csv")

lotr = read.csv("networks-id-volume1.csv")
#lotr = read.csv("networks-id-volume2.csv")
#lotr = read.csv("networks-id-volume3.csv")


lotrratio = as.data.frame(unique(lotr$IdSource))
colnames(lotrratio) = "IdSource"
rownames(lotrratio) = lotrratio$IdSource

onto = read.csv("ontology.csv", sep = ",")

lotrratio$Total_interactions = NA # I will be plotting the ratios between total interactions and type-specific interactions
types = unique(onto$subtype)
# Creating empty columns which will hold the total interactions with each type:
for (i in types)
{
  lotrratio[,i] = NA
}

# Next I will sum the total interactions for each character/ object:
for (object in lotrratio$IdSource)
{
  S = sum(lotr$Weight[lotr$IdSource == object])
  lotrratio$Total_interactions[lotrratio$IdSource == object] = S
}

# Now, I will study the interactions with each type:
for (object in lotrratio$IdSource) # For every object or character
{
  for (type in types) # Looking at their interactions with every type of object or character
  {
    targets = onto$id[onto$subtype == type] # Remembering the names of the objects of this type
    S = sum(lotr$Weight[lotr$IdSource == object & lotr$IdTarget %in% targets]) # Summing obect's interactions with them
    lotrratio[object,type] = S # And putting that in the corresponding cell
  }
}

# Now I will define the types:
lotrratio$Type = NA
for (object in lotrratio$IdSource)
{
  lotrratio$Type[lotrratio$IdSource == object] = as.character(onto$subtype[onto$id == object])
}

# And plot the result using my favourite package, ggplot2:
ggplot(lotrratio, aes(x = Type, y = Ainur/Total_interactions, col = Type)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  geom_point(show.legend = FALSE) +
  labs(title = 'Interactions with Ainur over total interactions in Volume 1', x = 'Source of interaction', y = 'Ainur/Total') +
  geom_boxplot(aes(fill = Type), alpha = 0.5, show.legend = FALSE)


# I performed statistical tests on the results. The quantitative statistical analysis did not yield very intersting results and I summarised the main findings in the main body        
kruskal.test(lotrratio$ainur/lotrratio$Total_interactions, as.factor(lotrratio$Type)) # The parameters of the function have to be changed depending on the desired analysis

wilcox.test(lotrratio$elves[lotrratio$Type == 'elves']/lotrratio$Total_interactions[lotrratio$Type == 'elves'], lotrratio$elves[lotrratio$Type == 'hobbit']/lotrratio$Total_interactions[lotrratio$Type == 'hobbit'])
#elves over men: elves comp with hobbit p = 0.05043
wilcox.test(lotrratio$dwarf[lotrratio$Type == 'dwarf']/lotrratio$Total_interactions[lotrratio$Type == 'dwarf'], lotrratio$dwarf[lotrratio$Type == 'hobbit']/lotrratio$Total_interactions[lotrratio$Type == 'hobbit'])
#dwarves over tot, dwarves comp with hobbit p = 0.004731
wilcox.test(lotrratio$elves[lotrratio$Type == 'elves']/lotrratio$Total_interactions[lotrratio$Type == 'elves'], lotrratio$elves[lotrratio$Type == 'dwarf']/lotrratio$Total_interactions[lotrratio$Type == 'dwarf'])
# Elves with dwarves, vol2: p = 0.00902