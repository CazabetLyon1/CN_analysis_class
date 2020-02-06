##This is a script to reorganise the LOTR dataframes to create a nodes df to import into Gephi


setwd("/home/masha/Desktop/M2/Complex_networks/Project/Downloaded_LOTR_csv")

#lotr_edge = read.csv("edges_vol1.csv")
#lotr_edge = read.csv("edges_vol2.csv")
lotr_edge = read.csv("edges_vol3.csv")


lotr_edge = lotr_edge[lotr_edge$Source %in% lotr$id,]
lotr_edge = lotr_edge[lotr_edge$Target %in% lotr$id,]

### Actually don't need following rows removing things

#I'd like to study the network with only characters, so first I'll get rid of interactions with places:
#remove_pla = c("bage", "bree", "mord", "hton", "rive", "gond", "isen", "mori", "roha", "lori", "orth", "andu", "dtow",
#               "nume", "shir", "loth", "morg", "mdoo", "osgi", "tiri", "edor")
#lotr = lotr[!lotr$Source %in% remove_pla & !lotr$Target %in% remove_pla,]

#Next I'll remove the groups, the ring and Shadowfax
#remove_gr = c("elve", "comp", "ring", "sfax", "tomb", "gber", "arat", "isil", "bill", "dwar", "hobb", "elen", "glorf", "orcs")
#lotr = lotr[!lotr$Source %in% remove_gr & !lotr$Target %in% remove_gr,]


#lotr = lotr[lotr$Type != "" & lotr$id != "" & lotr$Label != "" &
#              lotr$id != "" & lotr$Label != "" & lotr$Label != "" & lotr$Type != "" &
#              lotr$Type != "" & lotr$Label != "" & lotr$Label != "Isildur" & lotr$Label != "Elendil" &
#              lotr$id != "glorf" & lotr$id != "tomb" & lotr$id != "orcs",]#




#And export the .csv file
#write.csv(lotr_edge, "edges_vol1_for_gephi.csv", row.names = FALSE)
#write.csv(lotr_edge, "edges_vol2_for_gephi.csv", row.names = FALSE)
#write.csv(lotr_edge, "edges_vol3_for_gephi.csv", row.names = FALSE)












