# Coursera Developing Data Products - Class Project - server.R

library(shiny)
#require(UsingR)
merged <- read.table("RD_501_88101_merged-0.csv", header=TRUE, sep=",", na.strings="")


# Define server logic for PM2.5 Pollution Levels App
shinyServer(function(input, output) {

        state <- reactive({  
                input$state
        })
        
        # Generate a plot of the data. 
        output$main_plot <- renderPlot({                            
                par(mfrow=c(1,1))
                connector <- range(merged[, 2], merged[, 3])
                with(merged, plot(rep(1, 51), merged[, 2], xlim = c(0.5, 2.5), ylim=connector, xaxt = "n", xlab="", 
                                  ylab = "Mean PM2.5 levels by State"))
                with(merged, points(rep(2, 51), merged[, 3]))
                segments(rep(1,51), merged[, 2], rep(2, 52), merged[, 3])
                axis(1, c(1,2), c("1999", "2012"))
                
                # Individual chosen state highlighted in color
                segments(1, merged[which(merged$State.Name == state()), 2], 
                         2, merged[which(merged$State.Name == state()), 3], 
                         col="red", lwd=3)
        })
        
        output$table <- renderTable({
                merged[which(merged$State.Name == state()), ]
        })
        
        # Generate a help tab
        output$help <- renderUI({
                line1 <- "<h2>Help for PM2.5 Particulate Matter by State for 1999 and 2012 App.</h3><br><br>"
                line2 <- "<h3>Data obtained from the U.S. Environment Protection Agency collected from monitors throughout the U.S.</h2><br>"
                line3 <- '<h3>Fine particulate matter air pollution (PM2.5) from the <a href="http://www.epa.gov/ttn/airs/airsaqs/detaildata/downloadaqsdata.htm">EPA Air Quality System</a>'
                HTML(c(line1, line2, line3))
        })
})