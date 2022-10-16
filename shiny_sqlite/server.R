#Importation des libraries utile au projet. 
library(shiny)
library(ggplot2)
library(treemapify)
library(RSQLite)

#Importation des données via une base de données sur SQLite.
db <- dbConnect(dbDriver("SQLite"), dbname= "bdd.db")

data = dbGetQuery(db, "SELECT * 
                       FROM dim_global 
                       left join dim_industry ON dim_global.id_industry = dim_industry.id_industry 
                       left join dim_sector ON dim_global.id_sector = dim_sector.id_sector")

#Fonction serveur du r shiny.
shinyServer(function(input, output) {
  
  #Création de la fonction du treemap.
  graph1 <- reactive({
    
    #Création des données nécessaire pour la création du treemap.
    data_1 = setNames(aggregate(data["revenues"][data$year == input$select,] ~ data["sector"][data$year == input$select,],data, sum),c("Secteur","Revenues"))
    
    #Création du treemap.
    ggplot(data_1, aes(area = Revenues, fill = reorder(Secteur,Revenues),label = paste(Secteur,sep = "\n"))) +
      geom_treemap() +
      geom_treemap_text(colour = "black",place = "centre",size = 20) +
      theme(legend.position = "none")+
      scale_color_grey(start= 0.7, end=0.2, aesthetics = "fill")})
  
  #Création de l'ouput du treemap pour l'UI de l'application.      
  output$graph1 <- renderPlot({print(graph1())})
  
  #Création de l'ouput du bouton d'exportation du treemap en format png    
  output$downloadgraph1 = downloadHandler(
    filename = 'graph1.png',
    content = function(file) {
      ggsave(file, plot = graph1())})
  
  #Création du tableau des données du treemap
  output$tablegraph1 <- renderTable({
    
    #Création des données nécessaire pour la création du tableau de données
    data_1 = setNames(aggregate(data["revenues"][data$year == input$select,] ~ data["sector"][data$year == input$select,],data, sum),c("Secteur","Revenues"))
    
    #Création du tableau de données du treemap
    data_1 = data_1[order(data_1$Revenues, decreasing = T),]                                 
    print(data_1)})
  
  #Création de la fonction du graphique en barre.    
  graph2 <- reactive({
    
    #Création des données nécessaire pour la création du graphique en barre.
    a = data[data$year == input$year2,]
    b = a[data$sector == input$sector,]
    c = setNames(aggregate(b$revenue ~ b$industry, b,sum),c("Industrie","Revenues"))
    d = c[order(c$Revenues, decreasing = F),]
    
    #Création du graphique en barre.    
    ggplot(data = d, aes(x=Revenues, y=reorder(Industrie, Revenues))) + 
      geom_bar(stat = "identity",color="black", fill=rgb(0,0,0,0.5))})
  
  #Création de l'ouput du graphique en barre pour l'UI de l'application.  
  output$graph2 <- renderPlot({print(graph2())})
  
  #Création de l'ouput du bouton d'exportation du graphique en barre en format png.     
  output$downloadgraph2 = downloadHandler(
    filename = 'graph2.png',
    content = function(file) {
      ggsave(file, plot = graph2())})
  
  #Création du tableau des données du graphique en barre.   
  output$tablegraph2 <- renderTable({
    
    #Création des données nécessaire pour la création du tableau de données.
    a = data[data$year == input$year2,]
    b = a[data$sector == input$sector,]
    c = setNames(aggregate(b$revenue ~ b$industry, b,sum),c("Industrie","Revenues"))
    
    #Création du tableau de données du graphique en barre.
    d = c[order(c$Revenues, decreasing = F),]
    print(d)}) 
  
  #Création de la fonction du pie chart.        
  graph3 <- reactive({
    
    #Création des données nécessaire pour la création du pie chart.
    a = data[data$year == input$year3,]
    b = a[data$sector == input$sector2,]
    c = setNames(aggregate(b$employees ~ b$industry, b,sum),c("Industrie","Employer"))
    
    #Création du pie chart.
    ggplot(data = c, aes(y=reorder(Employer,Industrie), x="",fill=reorder(Employer,Industrie))) + 
      geom_bar(stat = "identity",width= 1)+
      coord_polar("y") +
      theme_void()+
      scale_color_grey(start= 0.8, end=0.2, aesthetics = "fill")})
  
  #Création de l'ouput du pie chart pour l'UI de l'application.     
  output$graph3 <- renderPlot({print(graph3())})
  
  #Création de l'ouput du bouton d'exportation du pie chart en format png.        
  output$downloadgraph3 = downloadHandler(
    filename = 'graph3.png',
    content = function(file) {
      ggsave(file, plot = graph3())
    })
  
  #Création du tableau des données du pie chart. 
  output$tablegraph3 <- renderTable({
    
    #Création des données nécessaire pour la création du tableau de données.
    a = data[data$year == input$year3,]
    b = a[data$sector == input$sector2,]
    
    #Création du tableau de données du pie chart.
    c = setNames(aggregate(b$employees ~ b$industry, b,sum),c("Industrie","Employer"))
    print(c)})
})
