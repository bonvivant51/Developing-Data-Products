# Coursera Developing Data Products - Class Project    ui.R

library(shiny)
#require(UsingR)
merged <- read.table("RD_501_88101_merged-0.csv", header=TRUE, sep=",", na.strings="")

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("Small Particulate Matter Counts by State for years 1999 and 2012\n"),
        
        # Sidebar contains a selection dropdown for all states represented in the data and allows the user to highlight
        #  a particular state of their choosing
        sidebarPanel(
                selectInput("state", "Choose a particular state to highlight:", 
                            choices = c(as.character(merged$State.Name))),
                helpText("Pull down to select individual states to highlight the change in average PM2.5 pollution over the span from 1999 to 2012.")
        ),
        
        # Show a tabset that includes a plot and Help view
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", plotOutput("main_plot"), tableOutput("table")),
                        tabPanel("Help", htmlOutput("help"))
                )
        )
))