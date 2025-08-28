## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse   = TRUE,
  comment    = "#>",
  fig.width  = 7,
  fig.height = 4
)

## -----------------------------------------------------------------------------
library(gridify)
library(magrittr)

## -----------------------------------------------------------------------------
library(ggplot2)

basic_plot <- ggplot2::ggplot(mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_point()

## -----------------------------------------------------------------------------
pharma_layout_letter()

## -----------------------------------------------------------------------------
grob_object <- gridify(
  object = basic_plot,
  layout = pharma_layout_letter()
)

## ----fig.width=7, fig.height=7------------------------------------------------
grob_object

## ----fig.width=7, fig.height=7------------------------------------------------
grob_object <- grob_object %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_1", "CONFIDENTIAL") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("header_right_3", "Data Cut-off: YYYY-MM-DD") %>%
  set_cell("output_num", "<Figure> xx.xx.xx") %>%
  set_cell("title_1", "<Title 1>") %>%
  set_cell("title_2", "<Title 2>") %>%
  set_cell("title_3", "<Optional Title 3>") %>%
  set_cell("by_line", "By: <GROUP>, <optionally: Demographic parameters>") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn") %>%
  set_cell("watermark", "DRAFT")

grob_object

## ----fig.width=7, fig.height=7------------------------------------------------
final_grob <- print(grob_object)

## -----------------------------------------------------------------------------
final_grob

## ----fig.width=7, fig.height=6------------------------------------------------
library(gt)

tab <- gt::gt(head(mtcars)) %>%
  gt::tab_options(
    table.width = gt::pct(100),
    data_row.padding = gt::px(10),
    table_body.hlines.color = "white",
    table.font.size = 12
  )

gridify(
  object = tab,
  layout = pharma_layout_base()
) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_right_1", "CONFIDENTIAL") %>%
  set_cell("title_1", "Table Title") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>") %>%
  set_cell("footer_right", "Page 1 of 1")

