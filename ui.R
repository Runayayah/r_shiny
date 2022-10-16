library(shiny)
library(shinythemes)
library(readr)
library(plotly)

dim_sector = read_delim("dim_sector.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
dim_industry = read_delim("dim_industry.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
dim_global <- read_delim("dim_global.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
merge=  merge(dim_sector,dim_global,by="id_sector")
data= merge(merge,dim_industry,by="id_industry")


shinyUI(fluidPage(theme= shinytheme("cosmo"),fluidRow(
  
navbarPage("Vincent Bak/ Lucien Hanquiez",
  
            tabPanel("Vu sur les secteur.",
                     
                      sidebarLayout(
                        sidebarPanel(
                          
                          titlePanel("Treemap des secteurs en fonction de leur industries."),
                          
                          selectInput("select", label = ("Selection d'une annee"), 
                                      choices = data[order(unique(data$year), decreasing = F),4], 
                                      selected = 1),
                          
                          downloadButton("downloadgraph1",label= "Telecharger Graphique"),
                          
                          tableOutput("tablegraph1")),
                        
                          mainPanel(plotOutput("graph1",width="100%",height = "900px"),)
                      )
                     ),
            
            tabPanel("Combien gagne les industries.",
                     
                       sidebarLayout(
                         sidebarPanel( 
                           
                         titlePanel("Top des industries en fonction des revenues."),
                         
                         selectInput("year2", label = ("Selection d'une annee"), 
                                     choices = data[order(unique(data$year), decreasing = F),4], 
                                     selected = 1),
                         selectInput("sector", label = ("Selection d'une industrie"), 
                                     choices = unique(data$sector), 
                                     selected = 1),
                         
                         downloadButton("downloadgraph2",label= "Telecharger Graphique"),
                         
                         tableOutput("tablegraph2")),
                         
                         mainPanel(plotOutput("graph2",width="100%",height = "900px"),)
                      )
                     ),
            
            tabPanel("Repartition des salariees",
                     
                      sidebarLayout(
                        sidebarPanel( 
                          
                          titlePanel("Pie chart de la repartition des employes en fonction des industries"),
                          
                          selectInput("year3", label = ("Selection d'une annee"), 
                                      choices = data[order(unique(data$year), decreasing = F),4], 
                                      selected = 1),
                          selectInput("sector2", label = ("Selection d'une industrie"), 
                                      choices = unique(data$sector), 
                                      selected = 1),
                          
                          downloadButton("downloadgraph3",label= "Telecharger Graphique"),
                          
                          tableOutput("tablegraph3")),
                        
                        mainPanel(plotOutput("graph3",width="100%",height = "900px"),)
                      )
                     )
           
           
      )
    )   
  )
)
