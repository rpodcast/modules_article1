#' Variable selection for plot user interface
#'
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
varselect_mod_ui <- function(id) {
  ns <- NS(id)
  
  # define choices for X and Y variable selection
  var_choices <- list(
    `Sale price` = "Sale_Price",
    `Total basement square feet` = "Total_Bsmt_SF",
    `First floor square feet` = "First_Flr_SF",
    `Lot Frontage` = "Lot_Frontage",
    `Lot Area` = "Lot_Area",
    `Masonry vaneer area` = "Mas_Vnr_Area",
    `1st floor square feet` = "First_Flr_SF",
    `2nd floor square feet` = "Second_Flr_SF",
    `Low quality finished square feet` = "Low_Qual_Fin_SF",
    `Above grade living area square feet` = "Gr_Liv_Area",
    `Garage area square feet` = "Garage_Area"
  )
  
  # assemble UI elements
  tagList(
    selectInput(
      ns("xvar"),
      "Select X variable",
      choices = var_choices,
      selected = "Lot_Area"
    ),
    selectInput(
      ns("yvar"),
      "Select Y variable",
      choices = var_choices,
      selected = "Sale_Price"
    )
  )
}

#' Variable selection module server-side processing
#'
#' @param input,output,session standard \code{shiny} boilerplate
#'
#' @return list with following components
#' \describe{
#'   \item{xvar}{reactive character indicating x variable selection}
#'   \item{yvar}{reactive character indicating y variable selection}
#' }
varselect_mod_server <- function(input, output, session) {
  
  return(
    list(
      xvar = reactive({ input$xvar }),
      yvar = reactive({ input$yvar })
    )
  )
}

#' Scatterplot module user interface
#'
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
#' @export
#'
#' @examples
scatterplot_mod_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        width = 6,
        plotOutput(ns("plot1"))
      ),
      column(
        width = 6,
        plotOutput(ns("plot2"))
      )
    )
  )
}

#' Scatterplot module server-side processing
#'
#' This module produces a scatterplot with the sales price against a variable selected by the user.
#' 
#' @param input,output,session standard \code{shiny} boilerplate
#' @param dataset data frame (non-reactive) with variables necessary for scatterplot
#' @param plot1_vars list containing reactive x-variable name (called `xvar`) and y-variable name (called `yvar`) for plot 1
#' @param plot2_vars list containing reactive x-variable name (called `xvar`) and y-variable name (called `yvar`) for plot 2
scatterplot_mod_server <- function(input, 
                                   output, 
                                   session, 
                                   dataset, 
                                   plot1vars, 
                                   plot2vars) {
  
  plot1_obj <- reactive({
    p <- scatter_sales(dataset, xvar = plot1vars$xvar(), yvar = plot1vars$yvar())
    return(p)
  })
  
  plot2_obj <- reactive({
    p <- scatter_sales(dataset, xvar = plot2vars$xvar(), yvar = plot2vars$yvar())
    return(p)
  })
  
  output$plot1 <- renderPlot({
    plot1_obj()
  })
  
  output$plot2 <- renderPlot({
    plot2_obj()
  })
}
