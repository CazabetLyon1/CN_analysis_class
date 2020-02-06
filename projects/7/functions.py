import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics.pairwise import pairwise_distances
import networkx as nx
import itertools
from networkx.drawing.nx_agraph import graphviz_layout
from __future__ import division 
import collections
from networkx.algorithms.richclub import rich_club_coefficient 
import seaborn as sns 
import random 
import math
from operator import itemgetter
from community import community_louvain
from networkx.algorithms import community
from itertools import count
import community
from math import floor

def Hist_degree(G,prob, Rand, Type):
    """ Plots the degree distribution of the directed graph G and of a random network.
    Inputs:
        G : directed graph
        prob: probability to add an edge between a pair of nodes in the Erdos Renyi model
        Rand: type of random model: CM (configuration model) or ER (Erdos-Renyi) or WS (Watts-Strogatz) or BA (Bbarabasi-Albert)
        Type: type of degree to be plotted: degree (both), in-degree (in) or out-degree (out)
    """

    if Rand=="ER":
        # erdos renyi
        random_graph= nx.erdos_renyi_graph(n= len(G), p= prob, directed = True) 
        
    elif Rand=='CM':
        #configuration model
        random_graph= nx.configuration_model(sorted([d for n, d in G.degree()]))
    elif Rand=='WS':
        # watts strogatz model
        random_graph= nx.watts_strogatz_graph(n= len(G), k=floor(stat.mean(sorted([d for n, d in G.degree()]))), p=prob)
    else:
        # barabasi albert graph
                random_graph= nx.barabasi_albert_graph(n= len(G), m=floor(stat.mean(sorted([d for n, d in G.degree()]))))
    
    if Type == 'out':
        out_list =[]
        out_list_r = []
        for elmt in G.out_degree:
            out_list.append(elmt[1])
          
        for relmt in random_graph.out_degree : 
            out_list_r.append(relmt[1])
        x1 = pd.Series(out_list_r)   
        x2 = pd.Series(out_list)
        
        newbins = np.arange(min(x2), max(x2), 1)
        plt.hist(x1, density=True, bins = newbins,alpha=0.5, color = 'grey')
        plt.hist(x2, density=True, bins = newbins, alpha=0.3, color='blue')
        plt.title('Out degree distribution')
        plt.xlabel('out degree')
        plt.ylabel('density')
        
    if Type == 'in':
        in_list =[]
        in_list_r = []
        for elmt in G.in_degree:
            in_list.append(elmt[1])
        for relmt in random_graph.in_degree : 
            in_list_r.append(relmt[1])
        x1 = pd.Series(in_list_r)
        x2 = pd.Series(in_list)
        
        newbins = np.arange(min(x2), max(x2), 1)
        plt.hist(x1, density=True, bins = newbins,alpha=0.5, color = 'grey')
        plt.hist(x2, density=True, bins = newbins,alpha=0.3, color='green')
        plt.title('In degree distribution')
        plt.xlabel('In degree')
        plt.ylabel('density')
       
        
    if Type == 'both':
        random_graph.to_undirected()
        both_list =[]
        both_list_r =[]
        for elmt in G.degree():
            both_list.append(elmt[1])
        for relmt in random_graph.degree : 
            both_list_r.append(relmt[1])
        
        x1 = pd.Series(both_list_r)
        x2 = pd.Series(both_list)
        newbins = np.arange(min(x2), max(x2), 1)
        plt.hist(x1, density=True,bins = newbins, alpha=0.5, color = 'grey')
        plt.hist(x2, density=True, bins = newbins,alpha=0.3, color='red')
        plt.title('Degree distribution')
        plt.xlabel('degree')
        plt.ylabel('density')
        
    plt.legend(['random graph distribution', 'degree distribution'])
     
    return x2 , x1, random_graph

