library(shiny)

shinyServer(
  function(input, output) {
    
    # functions
    source("./geom_smooth_funct.R")
    lineal_function <- function(a, b)
    {
      x <- seq(-5, 5, 0.5)
      y <- a*x + b
      y
    }    
    parabola <- function(a, b, c)
    {
      x <- seq(-5, 5, 0.5)
      y <- a*x^2 + b*x + c
      y
    }   
    
    output$my_test1 <- renderPlot({
      # next text only when go button press
      input$goButtonParabola
      if (input$goButtonParabola == 0)
      {
        #data to show
        dataOld_p <<- read.table(text = ""
                                 , colClasses = c("numeric", "numeric", "numeric", "numeric", "numeric", "factor")
                                 , col.names = c("a", "b", "c", "x", "y", "type"))   
      }
      
      # plot ony when go button pressed 
      g <- isolate({
        
        
        # calculate the points to plot the lineal function
        y <- parabola(input$a, input$b, input$c)
        
        # select the x range to plot
        x <- seq(-5, 5, 0.5)
        
        # create the data frame to plot
        data_new <<- data.frame(x = x, y = y, type = "new")
        data_new$a <<- input$a
        data_new$b <<- input$b
        data_new$c <<- input$c
        dataToPlot <<- rbind(dataOld_p, data_new)
        
        g <- ggplot(dataToPlot, aes(x = x, y = y, color = type))
        g <- g + geom_line()
        g <- g + xlim(c(-5, 5))
        g <- g + ylim(c(-8, 8))
        
        # save old data
        dataOld_p <<- data_new
        dataOld_p$type <<- "old"
        
        # old equation
        output$newEquation <- renderText({paste("y = ", {input$a}, " * x^2 + ",
{input$b}, " * x + ",
{input$c})})

output$oldEquation <- renderText({paste("y = ", {subset(dataToPlot, type == "old")$a[1]}, " * x^2 + ",
{subset(dataToPlot, type == "old")$b[1]}, " * x + ",
{subset(dataToPlot, type == "old")$c[1]})})

#return the plot
g
      })
#return the plot
g
    })

output$my_test2 <- renderPlot({
  # select that we want to plot only when go button is selected
  input$goButtonLineal
  
  #initialize
  if (input$goButtonLineal == 0)
  {
    #data to show initialization
    dataOld_l <<- read.table(text = ""
                             , colClasses = c("numeric", "numeric", "numeric", "numeric", "factor")
                             , col.names = c("m", "n", "x", "y", "type"))
  }
  
  # do plot
  g <- isolate({
    # calculate the points to plot the lineal function
    y <- lineal_function(input$m, input$n)
    
    # select the x range to plot
    x <- seq(-5, 5, 0.5)
    
    # create the data frame to plot
    data_new <<- data.frame(x = x, y = y, type = "new")
    data_new$m <<- input$m
    data_new$n <<- input$n
    dataToPlot <<- rbind(dataOld_l, data_new)
    
    g <- ggplot(dataToPlot, aes(x = x, y = y, color = type))
    g <- g + geom_line()
    g <- g + stat_smooth_func(geom="text",method="lm",hjust=0,parse=TRUE)
    g <- g + xlim(c(-5, 5))
    g <- g + ylim(c(-8, 8))
    
    # save old data
    dataOld_l <<- data_new
    dataOld_l$type <<- "old"
    
    #return the plot
    g
  })
  #return the plot
  g
})

    
})