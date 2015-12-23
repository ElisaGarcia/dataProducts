shinyUI(fluidPage(
  titlePanel("Parabola or lineal function"),
  sidebarLayout(
    sidebarPanel(
      selectInput("my_choices", "Parabola or Lineal",choices = c("Parabola", "Lineal"), selected = 1),width=2),
    mainPanel(
      conditionalPanel(
        condition = "input.my_choices == 'Parabola'",
        sidebarPanel(
          sliderInput('a', 'a', value = 1, min = -5, max = 5, step = 0.1)
          , sliderInput('b', 'b', value = 1, min = -5, max = 5, step = 0.1)
          , sliderInput('c', 'c', value = 0, min = -5, max = 5, step = 0.1)
        ),
        actionButton("goButtonParabola", "Go Parabola!"),
        p('equation new'),
        textOutput('newEquation'),
        p('equation old'),
        textOutput('oldEquation'),
        plotOutput('my_test1')
      ),
      conditionalPanel(
        condition = "input.my_choices == 'Lineal'",
        sidebarPanel(
          sliderInput('m', 'slope (m)', value = 1, min = -5, max = 5, step = 0.1)
          , sliderInput('n', 'intercept (n)', value = 0, min = -5, max = 5, step = 0.1)
        ),
        actionButton("goButtonLineal", "Go Lineal!"),
        plotOutput("my_test2")
      )
    )
  )
  ))


  
 