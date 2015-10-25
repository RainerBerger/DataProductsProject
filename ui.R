shinyUI(
  pageWithSidebar(
    headerPanel("Financial Risk and Returns"),
    sidebarPanel(
      h5("Enter your initial wealth and the number of years to project"),
      numericInput('age', 'Age (Years)', 50, min = 1, max = 100, step = 1),
      numericInput('horizon', 'Projection Horizon (Years)', 34, min = 1, max = 100, step = 1),
      numericInput('initwealth', 'Initial Wealth (M)', 5, min = 1, max = 1000, step = 0.1),
      h5("Choose the level of risk that you are willing to take and the expected returns"),
      sliderInput('risk', 'Risk (%)', value = 1, min = 0, max = 10, step = 0.1,),
      sliderInput('returns', 'Returns (%)', value = 2, min = 0, max = 20, step = 0.1,)
    ),
    mainPanel(
      h3('Projected Wealth at end of Simulation (M)'),
      verbatimTextOutput("projWealth"),
      #h3('Chance of Loss (Ann)'),
      #verbatimTextOutput("chanceLoss"),
      h3(""),
      h3("Projected Wealth"),
      h5("Your projected wealth is estimated to lie within the upper and lower lines shown."),
      h5("The middle line is the expected mean and the other lines reprent one standard variation bounds."),
      plotOutput('newHist')
    )
  )
)