#Importation des libraries utile au projet. 
library(shiny)
library(RSQLite)

#Importation des données via des fichiers csv.
db <- dbConnect(dbDriver("SQLite"), dbname= "bdd.db")

data = dbGetQuery(db, "SELECT * 
                       FROM dim_global 
                       left join dim_industry ON dim_global.id_industry = dim_industry.id_industry 
                       left join dim_sector ON dim_global.id_sector = dim_sector.id_sector")

#Fonction de l'UI du r shiny
shinyUI(fluidPage(includeCSS("cosmo.min.css"),fluidRow(
  
  #Création des onglets du r shiny.  
  navbarPage("Vincent Bak/ Lucien Hanquiez",
             
             #Premier pannel du r shiny.  
             tabPanel("Vu sur les secteur.",
                      
                      #Création du layout du première onglet.
                      sidebarLayout(
                        
                        #Création de l'affichage des filtres et du tableau de données. 
                        sidebarPanel(
                          
                          #Titre du graphique 
                          titlePanel("Treemap des secteurs en fonction de leur industries."),
                          
                          #Filtre sur les années
                          selectInput("select", label = ("Selection d'une annee"), 
                                      choices = data$year, 
                                      selected = 1),
                          
                          #Bouton de téléchargement du graphique. 
                          downloadButton("downloadgraph1",label= "Telecharger Graphique"),
                          
                          #Tableau des données du graphique.
                          tableOutput("tablegraph1")),
                        
                        #Afficahge du graphique.
                        mainPanel(plotOutput("graph1",width="100%",height = "900px"),)
                      )
             ),
             
             #Deuxièmes pannel du r shiny.
             tabPanel("Combien gagne les industries.",
                      
                      #Création du layout du deuxième onglet.
                      sidebarLayout(
                        
                        #Création de l'affichage des filtres et du tableau de données.
                        sidebarPanel( 
                          
                          #Titre du graphique.
                          titlePanel("Top des industries en fonction des revenues."),
                          
                          #Filtre sur les années.
                          selectInput("year2", label = ("Selection d'une annee"), 
                                      choices = data$year, 
                                      selected = 1),
                          
                          #Filtre sur les industries.
                          selectInput("sector", label = ("Selection d'une industrie"), 
                                      choices = unique(data$sector), 
                                      selected = 1),
                          
                          #Bouton de téléchargement du graphique. 
                          downloadButton("downloadgraph2",label= "Telecharger Graphique"),
                          
                          #Tableau des données du graphique.
                          tableOutput("tablegraph2")),
                        
                        #Affichage du graphique. 
                        mainPanel(plotOutput("graph2",width="100%",height = "900px"),)
                      )
             ),
             
             #Troisième onglet du shiny.
             tabPanel("Repartition des salariees",
                      
                      #Création du layout du troisième onglet.                    
                      sidebarLayout(
                        
                        #Création de l'affichage des filtres et du tableau de données.
                        sidebarPanel( 
                          
                          #Titre du graphique
                          titlePanel("Pie chart de la repartition des employes en fonction des industries"),
                          
                          #Filtre sur les années 
                          selectInput("year3", label = ("Selection d'une annee"), 
                                      choices = data$year, 
                                      selected = 1),
                          
                          #Filtre sur les industries
                          selectInput("sector2", label = ("Selection d'une industrie"), 
                                      choices = unique(data$sector), 
                                      selected = 1),
                          
                          #Bouton de téléchargement du graphique. 
                          downloadButton("downloadgraph3",label= "Telecharger Graphique"),
                          
                          #Tableau des données du graphique.
                          tableOutput("tablegraph3")),
                        
                        #Affichage du graphique.
                        mainPanel(plotOutput("graph3",width="100%",height = "900px"),)
                      )
             )
             
             
  )
)   
)
)
