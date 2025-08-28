## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse   = TRUE,
  comment    = "#>",
  fig.width  = 7,
  fig.height = 4
)

## ----fig.width=7, fig.height=7------------------------------------------------
library(gridify)
# For the native pipe (|>), R 4.1.0 or higher is recommended.
# Otherwise, you can use magrittr's %>%.
library(magrittr)

library(ggplot2)

# Create and print a gridify object
grid_call_behind <- gridify(
  object = ggplot2::ggplot(
    data = mtcars,
    ggplot2::aes(x = mpg, y = wt)
  ) +
    ggplot2::geom_line(),
  layout = complex_layout(scales = "fixed")
) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer") %>%
  print()

# The underlying grid call is returned invisibly by the print() method.
# We can inspect or store it for further manipulations:
grid_call_behind

## ----fig.width=7, fig.height=7------------------------------------------------
# Retrieve the main object- either a figure or table
OBJECT <- attr(grid_call_behind, "env")[["OBJECT"]]
# Redraw the graphics by eval of the grid call
grid::grid.draw(eval(grid_call_behind))

