library(shiny)

# ui.R

shinyUI(fluidPage(
  titlePanel("Boat Run Explorer"),
  sidebarLayout(position="left",
                
                sidebarPanel(
                  helpText(h4("Select settings for Water Quality display")),
                  selectInput("select", label = h5("Choose a Water Quality variable to display"), 
                              choices = list("Temperature (C)" = 1, "Salinity (ppt)" = 2,  
                                              "Nitrate + Nitrite (mg/L)" = 3, "Dissolved Oxygen Saturation (%)" = 4,
                                             "Dissolved Oxygen (mg/L)" = 5, "Secchi depth (m)" = 6, "Turbidity (NTU)"=7), 
                              selected = 2),
                  br(),
                  sliderInput("slider2", "Data Year Window",
                              min = 1999, max = 2013, value = c(1999, 2013), format="####"),
                  br(),
                  radioButtons("radio", label = h5("Display by"),
                               choices = list("River Mile" = 1, "Month" = 2
                                              ),selected = 1),
                  br(),
                  br(),
                  img(src="DRBClogo.jpg", height = 100, width = 150, align="center")
                  
                ),
                
                
                mainPanel(
                  
                  h4(textOutput("caption")),
                  h4(textOutput("year")),
                  h6(textOutput("RM")),
                  plotOutput("BRBox"),
                  a(href="http://www.state.nj.us/drbc/quality/datum/ambient/", "Learn more about the Boat Run Monitoring Program"),
                  br(),
                  a(href="http://en.wikipedia.org/wiki/Box_plot", "What's a box plot?"),
                  br(),
                  p("programmed by John Yagecic (John.Yagecic@drbc.state.nj.us)")
                  
                )
                )))

