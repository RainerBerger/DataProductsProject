#
# Program performs a financial projection given risk and returns input by user
#
# The horizon is the number of years for which the projection should run
#

calc_ages <- function(age,horizon) {
  ages <- rep(age, horizon)
  for(i in 2:horizon) 
  {
    ages[i] <- ages[i-1]+1
  }
  return(ages)
}

# Calculate the projected wealth given the desired returns
calc_wealth <- function(initWealth, retn, horizon) {
  wealth <- rep(initWealth, horizon)
  retpercent <- retn/100.0
  for(i in 2:horizon)
  {
    wealth[i] <- wealth[i-1]*(1+retpercent)
  }
  return(wealth)
}

# Calculate the standard deviations given the risks
calc_stds <- function(risk, horizon) {
  stds <- rep(risk, horizon) 
  for(i in 2:horizon)
  {
    stds[i] <- risk*sqrt(i)
  }
  return(stds)
}

# Returns the upper curve which represents the mean + 1 sigma for the
# projected wealth
calc_upper67 <- function(wealth, stds, horizon) {
  upper67 <- rep(wealth[1], horizon) 
  for(i in 2:horizon)
  {
    upper67[i] <- wealth[i]*(1+stds[i]/100.0)
  }
  return(upper67)
}

# Returns the lower curve which represents the mean - 1 sigma for the
# projected wealth
calc_lower67 <- function(wealth, stds, horizon) {
  lower67 <- rep(wealth[1], horizon) 
  for(i in 2:horizon)
  {
    lower67[i] <- wealth[i]*(1-stds[i]/100.0)
  }
  return(lower67)
}

calc_wealth2 <- function(initWealth, retn, horizon) {
  wealth <- rep(initWealth, horizon)
  retpercent <- retn/100.0
  for(i in 2:horizon)
  {
    wealth[i] <- wealth[i-1]*(1+retpercent)
  }
  return(wealth[34])
}

shinyServer(
  function(input, output) {
    ages <- reactive({calc_ages(input$age, input$horizon)})
    wealth <- reactive({calc_wealth(input$initwealth, input$returns, input$horizon)})
    stds <- reactive({calc_stds(input$risk, input$horizon)})
    upper67 <- reactive({calc_upper67(wealth(), stds(), input$horizon)})
    lower67 <- reactive({calc_lower67(wealth(), stds(), input$horizon)})
    pWealth <- reactive({calc_wealth2(input$initwealth, input$returns, input$horizon)})
    
    output$projWealth <- renderPrint({pWealth()})
    output$chanceLoss <- renderPrint({input$risk})
    output$newHist <- renderPlot({
      plot(wealth(), type="l", col="blue", xlab="Years", ylab="Projected Wealth (M)")
      lines(upper67(), type="l", lty=2, lwd=2, col="green")
      lines(lower67(), type="l", lty=3, lwd=2, col="forestgreen")
    })
  }
)