# load packages
library(shiny)
library(AmesHousing)
library(dplyr)
library(rlang)
library(ggplot2)
library(scales)

# load separate module and function scripts
source("modules.R")
source("helpers.R")

# user interface
ui <- fluidPage(
  
  titlePanel("Ames Housing Data Explorer"),
  
  fluidRow(
    column(
      width = 3,
      wellPanel(
        varselect_mod_ui("plot1_vars")
      )
    ),
    column(
      width = 6,
      scatterplot_mod_ui("plots")
    ),
    column(
      width = 3,
      wellPanel(
        varselect_mod_ui("plot2_vars")
      )
    )
  )
)

# server logic
server <- function(input, output, session) {
  
  # prepare dataset
  ames <- make_ames()
  
  # execute plot variable selection modules
  plot1vars <- callModule(varselect_mod_server, "plot1_vars")
  plot2vars <- callModule(varselect_mod_server, "plot2_vars")
  
  # execute scatterplot module
  res <- callModule(scatterplot_mod_server,
                    "plots",
                    dataset = ames,
                    plot1vars = plot1vars,
                    plot2vars = plot2vars)
  
}

# Run the application 
shinyApp(ui = ui, server = server)
