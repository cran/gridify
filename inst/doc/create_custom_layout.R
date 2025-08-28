## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## ----layout-basics------------------------------------------------------------
library(gridify)
# (to use |> version 4.1.0 of R is required, for lower versions we recommend %>% from magrittr)
library(magrittr)

# In the simple_layout there are three rows and one column
# creating a grid of three cells vertically.
show_layout(simple_layout())

## ----example-layout-----------------------------------------------------------
new_layout <- gridifyLayout(
  nrow = 4L,
  ncol = 2L,
  heights = grid::unit(c(1, 1, 1, 0.05), c("lines", "lines", "null", "npc")),
  widths = grid::unit(c(0.5, 0.5), "npc"),
  margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "npc"),
  global_gpar = grid::gpar(),
  background = grid::get.gpar()$fill,
  adjust_height = FALSE,
  object = gridifyObject(row = 3, col = 1:2),
  cells = gridifyCells(
    company = gridifyCell(row = 1, col = 2, x = 1, hjust = 1, y = 1, vjust = 1),
    title = gridifyCell(row = 2, col = 1, x = 1, hjust = 0.5),
    footer = gridifyCell(row = 4, col = 1, x = 0, hjust = 0)
  )
)

gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = new_layout
) %>%
  set_cell("company", "Company Ltd") %>%
  set_cell("title", "This is my title") %>%
  set_cell("footer", "This is a very long footer with lots of words")

## ----margin-argument----------------------------------------------------------
# # a 10% margin on all sides
# grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "npc")

## -----------------------------------------------------------------------------
# # set the background colour to be the default
# background <- grid::get.gpar()$fill
# 
# # set the background colour to a specific colour
# background <- "blue"
# background <- "#96BA39"

## ----adding-object-argument---------------------------------------------------
# # an object that spans only row 3 but both columns 1 and 2
# gridifyObject(row = 3, col = 1:2)

## ----scales-argument-free-----------------------------------------------------
simple_layout(scales = "free")

## ----show-scales-argument-free------------------------------------------------
show_layout(simple_layout(scales = "free"))

## ----scales-argument-fixed----------------------------------------------------
simple_layout(scales = "fixed")

## ----show-scales-argument-fixed-----------------------------------------------
# As no lines were defined, the object takes up the whole space below
show_layout(simple_layout(scales = "fixed"))

## ----how-add-scales-custom-layout---------------------------------------------
scales_example_layout <- function(
    margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "npc"),
    global_gpar = grid::gpar(),
    scales = c("npc", "lines")) {
  scales <- match.arg(scales, c("npc", "lines"))

  heights <- if (scales == "npc") {
    grid::unit(c(0.15, 0.7, 0.15), "npc")
  } else {
    grid::unit(c(0, 1, 0), "lines")
  }


  gridifyLayout(
    nrow = 3L,
    ncol = 1L,
    heights = heights,
    widths = grid::unit(1, "npc"),
    margin = margin,
    global_gpar = global_gpar,
    background = grid::get.gpar()$fill,
    adjust_height = TRUE,
    object = gridifyObject(row = 2, col = 1),
    cells = gridifyCells(
      title = gridifyCell(row = 1, col = 1),
      footer = gridifyCell(row = 3, col = 1)
    )
  )
}

scales_example_layout(scales = "npc")
show_layout(scales_example_layout(scales = "npc"))
scales_example_layout(scales = "lines")
show_layout(scales_example_layout(scales = "lines"))

## ----adding-cells-------------------------------------------------------------
# gridifyCells(
#   company = gridifyCell(row = 1, col = 2, x = 1, hjust = 1, y = 1, vjust = 1),
#   title = gridifyCell(row = 2, col = 1, x = 1, hjust = 0.5),
#   footer = gridifyCell(row = 4, col = 1, x = 0, hjust = 0)
# )

## ----default-graphical-parameters---------------------------------------------
new_layout <- gridifyLayout(
  nrow = 3L,
  ncol = 1L,
  heights = grid::unit(c(0.1, 0.8, 0.1), "npc"),
  widths = grid::unit(1, "npc"),
  margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "inches"),
  # default graphics for whole output set in global_gpar
  global_gpar = grid::gpar(fontfamiy = "Courier", col = "navy"),
  background = grid::get.gpar()$fill,
  adjust_height = FALSE,
  object = gridifyObject(row = 2, col = 1),
  cells = gridifyCells(
    # default graphics for title cell here:
    title = gridifyCell(row = 1, col = 1, gpar = grid::gpar(fontsize = 20)),
    footer = gridifyCell(row = 3, col = 1)
  )
)

gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = new_layout
) %>%
  set_cell("title", "This is a title") %>%
  # graphics specs can be overwritten in set_cell
  set_cell("footer", "This is a footer", gpar = grid::gpar(col = "purple"))

## ----default-graphical-parameters-text----------------------------------------
new_layout <- gridifyLayout(
  nrow = 3L,
  ncol = 1L,
  heights = grid::unit(c(0.1, 0.8, 0.1), "npc"),
  widths = grid::unit(1, "npc"),
  margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "inches"),
  global_gpar = grid::gpar(
    fontfamiy = "Courier",
    col = "navy",
    fontface = "italic"
  ), # default italic text for the whole output
  background = grid::get.gpar()$fill,
  adjust_height = FALSE,
  object = gridifyObject(row = 2, col = 1),
  cells = gridifyCells(
    title = gridifyCell(row = 1, col = 1),
    footer = gridifyCell(row = 3, col = 1)
  )
)

# overwriting the default fontface in the footer cell in the call to set_cell
# so the footer will now have bold and italic instead of the default italic
gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = new_layout
) %>%
  set_cell("title", "This is a title") %>%
  set_cell("footer", "This is a footer", gpar = grid::gpar(fontface = "bold.italic"))

## ----default-cell-text--------------------------------------------------------
new_layout <- gridifyLayout(
  nrow = 4L,
  ncol = 2L,
  heights = grid::unit(c(1, 1, 1, 0.05), c("lines", "lines", "null", "npc")),
  widths = grid::unit(c(0.5, 0.5), "npc"),
  margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "npc"),
  global_gpar = grid::gpar(),
  background = grid::get.gpar()$fill,
  adjust_height = FALSE,
  object = gridifyObject(row = 3, col = 1:2),
  cells = gridifyCells(
    company = gridifyCell(row = 1, col = 2, x = 1, hjust = 1, y = 1, vjust = 1),
    title = gridifyCell(row = 2, col = 1, text = "Default Title", x = 1, hjust = 0.5),
    footer = gridifyCell(row = 4, col = 1, x = 0, hjust = 0)
  )
)

gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = new_layout
) %>%
  set_cell("company", "Company Ltd") %>%
  set_cell("footer", "This is a very long footer with lots of words")

## ----adding-watermark---------------------------------------------------------
new_layout <- gridifyLayout(
  nrow = 3L,
  ncol = 1L,
  heights = grid::unit(c(0.05, 0.9, 0.05), "npc"),
  widths = grid::unit(1, "npc"),
  margin = grid::unit(c(t = 0.1, r = 0.1, b = 0.1, l = 0.1), units = "cm"),
  global_gpar = grid::gpar(),
  background = grid::get.gpar()$fill,
  adjust_height = FALSE,
  object = gridifyObject(row = 2, col = 1),
  cells = gridifyCells(
    title = gridifyCell(row = 1, col = 1),
    footer = gridifyCell(row = 3, col = 1),
    watermark = gridifyCell(row = 1:3, col = 1, rot = 45, gpar = grid::gpar(fontsize = 90, alpha = 0.3))
  )
)

gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = new_layout
) %>%
  set_cell("watermark", "DRAFT")

