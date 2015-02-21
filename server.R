library(shiny)
BR<-data.frame(read.csv("data/BREdata07012014.csv"))
BR$Date<-as.Date(BR$Date, format="%m/%d/%Y %I:%M")
BR$Month2<-as.character(BR$Date, "%b")
BR$Month2<-factor(BR$Month2, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

BR$NumDate <-as.numeric(BR$Date)
# Use only Ammonia as NH3
#  stopped here  ****************************
LabelParms = c("Temperature (C)", "Salinity (ppt)",  
            "Nitrate + Nitrite (mg/L)", "Dissolved Oxygen Saturation (%)",
            "Dissolved Oxygen (mg/L)", "Secchi depth (m)", "Turbidity (NTU)")

BRparms=c("Temperature, water",
         "Salinity",
         "Inorganic nitrogen (nitrate and nitrite) as N", 
         "Dissolved oxygen saturation",
         "Dissolved oxygen (DO)",
         "Depth, Secchi disk depth",
         "Turbidity"
         )

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   
  output$caption <- renderText({as.character(LabelParms[as.numeric(input$select)])})
  output$year <-renderText({
    y1 <- as.character(as.numeric(input$slider2[1]))
    y2 <- as.character(as.numeric(input$slider2[2]))
    paste(y1, " through ", y2)
  })
  output$RM <- renderText({
    if (as.numeric(input$radio)==1){
      RMText <- "River Mile Guide:  Mouth of Delaware Bay at River Mile 0,   Ben Franklin Bridge at River Mile 100,   Trenton at River Mile 133"
    }
    if (as.numeric(input$radio)==2){
      RMText <- " "
    }
      RMText
  })
  output$BRBox <- renderPlot({
    EYear <- as.character(as.numeric(input$slider2[2]))
    SYear <- as.character(as.numeric(input$slider2[1]))
    EndNum <- as.numeric(as.Date(paste0(EYear,"-01-01"), "%Y-%m-%d"))
    StartNum <- as.numeric(as.Date(paste0(SYear,"-01-01"), "%Y-%m-%d"))
    BRsub <-BR[((BR$NumDate > StartNum) & (BR$NumDate < EndNum)) & BR$Characteristic.Name==BRparms[as.numeric(input$select)],]
    mylab<-as.character(LabelParms[as.numeric(input$select)])
    if (as.numeric(input$radio)==1){
    boxplot(Result ~ RM, data=BRsub, ylab=mylab, las=3, cex.axis=0.8, xlab="River Mile")
    }
    if (as.numeric(input$radio)==2){
      boxplot(Result ~ Month2, data=BRsub, ylab=mylab, xlab="Month")
    }
  })
  output$bylabel <- renderText({"programmed by John Yagecic"})
  output$email <- renderText({"JYagecic@gmail.com"})
})

