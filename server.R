#Importation des libraries utile au projet. 

library(shiny)
library(shinythemes)
library(ggplot2)
library(treemapify)
library(readr)


dim_sector = read_delim("dim_sector.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
dim_industry = read_delim("dim_industry.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
dim_global <- read_delim("dim_global.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)

shinyServer(function(input, output) {

    output$graph1 <- renderPlot({
      data =  merge(dim_sector,dim_global,by="id_sector")
      data_1 = setNames(aggregate(data["revenues"][data$year == input$select,] ~ data["sector"][data$year == input$select,],data, sum),c("Secteur","Revenues"))
      ggplot(data_1, aes(area = Revenues, fill = reorder(Secteur,Revenues),label = paste(Secteur,sep = "\n"))) +
        geom_treemap() +
        geom_treemap_text(colour = "black",
                          place = "centre",
                          size = 20) +
        theme(legend.position = "none")+
        scale_color_grey(start= 0.7, end=0.2, aesthetics = "fill")
                             })
    
      output$tablegraph1 <- renderTable({
      data =  merge(dim_sector,dim_global,by="id_sector")
      data_1 = setNames(aggregate(data["revenues"][data$year == input$select,] ~ data["sector"][data$year == input$select,],data, sum),c("Secteur","Revenues"))
      data_1 = data_1[order(data_1$Revenues, decreasing = T),]                                 
      print(data_1)
                                   })
    
    output$graph2 <- renderPlot({
      merge=  merge(dim_sector,dim_global,by="id_sector")
      data= merge(merge,dim_industry,by="id_industry")
      a = data[data$year == input$year2,]
      b = a[data$sector == input$sector,]
      c = setNames(aggregate(b$revenue ~ b$industry, b,sum),c("Industrie","Revenues"))
      d = c[order(c$Revenues, decreasing = F),]
      
      ggplot(data = d, aes(x=Revenues, y=reorder(Industrie, Revenues))) + 
        geom_bar(stat = "identity",color="black", fill=rgb(0,0,0,0.5))
      
    })
    
    output$tablegraph2 <- renderTable({
      merge=  merge(dim_sector,dim_global,by="id_sector")
      data= merge(merge,dim_industry,by="id_industry")
      a = data[data$year == input$year2,]
      b = a[data$sector == input$sector,]
      c = setNames(aggregate(b$revenue ~ b$industry, b,sum),c("Industrie","Revenues"))
      d = c[order(c$Revenues, decreasing = F),]
      print(d)
      
    }) 
    
    output$graph3 <- renderPlot({
      merge=  merge(dim_sector,dim_global,by="id_sector")
      data= merge(merge,dim_industry,by="id_industry")
      a = data[data$year == input$year3,]
      b = a[data$sector == input$sector2,]
      c = setNames(aggregate(b$employees ~ b$industry, b,sum),c("Industrie","Employer"))
      
      ggplot(data = c, aes(y=reorder(Employer,Industrie), x="",fill=reorder(Employer,Industrie))) + 
        geom_bar(stat = "identity",width= 1)+
        coord_polar("y") +
        theme_void()+
        scale_color_grey(start= 0.8, end=0.2, aesthetics = "fill")
      
    })
    
    output$tablegraph3 <- renderTable({
      merge=  merge(dim_sector,dim_global,by="id_sector")
      data= merge(merge,dim_industry,by="id_industry")
      a = data[data$year == input$year3,]
      b = a[data$sector == input$sector2,]
      c = setNames(aggregate(b$employees ~ b$industry, b,sum),c("Industrie","Employer"))
      print(c)
      
    })

})
