plot_labeller <- function(l, varname) {
  if (varname == "Sale_Price") {
    res <- dollar(l)
  } else {
    res <- comma(l)
  }
  return(res)
}

#' Produce scatterplot with variables selected by the user
#'
#' @param data data frame with variables necessary for scatterplot
#' @param xvar variable (string format) to be used on x-axis 
#' @param yvar variable (string format) to be used on y-axis 
#'
#' @return {\code{ggplot2} object for the scatterplot
#' @export
#'
#' @examples
#' plot_obj <- scatter_sales(data = ames, xvar = "Lot_Frontage", yvar = "Sale_Price")
#' plot_obj
scatter_sales <- function(dataset, xvar, yvar) {
  
  x <- rlang::sym(xvar)
  y <- rlang::sym(yvar)
  
  p <- ggplot(dataset, aes(x = !!x, y = !!y)) +
    geom_point() +
    scale_x_continuous(labels = function(l) plot_labeller(l, varname = xvar)) +
    scale_y_continuous(labels = function(l) plot_labeller(l, varname = yvar)) +
    theme(axis.title = element_text(size = rel(1.2)),
          axis.text = element_text(size = rel(1.1)))

  return(p)
}
