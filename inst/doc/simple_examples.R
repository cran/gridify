## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## -----------------------------------------------------------------------------
# Load the necessary libraries
library(ggplot2)
# (to use |> version 4.1.0 of R is required, for lower versions we recommend %>% from magrittr)
library(magrittr)

# Create a scatter plot
mtcars %>%
  {
    ggplot2::ggplot(., aes(x = mpg, y = wt)) +
      ggplot2::geom_point()
  } %>%
  print()

## -----------------------------------------------------------------------------
library(gridify)
fig_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

## -----------------------------------------------------------------------------
g <- gridify(fig_obj, layout = simple_layout())

## -----------------------------------------------------------------------------
g <- g %>%
  set_cell("title", "Title") %>%
  set_cell("footer", "Footer")

print(g)

## -----------------------------------------------------------------------------
fig_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

## -----------------------------------------------------------------------------
g <- gridify(fig_obj, layout = complex_layout()) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer")

print(g)

## ----fig.width = 7, fig.height = 5.5------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(object = figure_obj, layout = pharma_layout_base()) %>%
  set_cell("header_left_1", "Left Header 1") %>%
  set_cell("header_left_2", "Left Header 2") %>%
  set_cell("header_left_3", "Left Header 3") %>%
  set_cell("header_right_1", "Right Header 1") %>%
  set_cell("header_right_2", "Right Header 2") %>%
  set_cell("header_right_3", "Right Header 3") %>%
  set_cell("output_num", "Output") %>%
  set_cell("title_1", "Title 1") %>%
  set_cell("title_2", "Title 2") %>%
  set_cell("title_3", "Title 3") %>%
  set_cell("by_line", "By Line") %>%
  set_cell("note", "Note") %>%
  set_cell("references", "References") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_right", "Right Footer") %>%
  set_cell("watermark", "Watermark")

print(g)

## ----fig.width = 7, fig.height = 5--------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(object = figure_obj, layout = pharma_layout_letter()) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("output_num", "<Figure> xx.xx.xx") %>%
  set_cell("title_1", "<Title 1>") %>%
  set_cell("title_2", "<Title 2>") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn") %>%
  set_cell("watermark", "Draft")

print(g)

## ----fig.width = 7, fig.height = 5--------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(object = figure_obj, layout = pharma_layout_A4()) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("output_num", "<Figure> xx.xx.xx") %>%
  set_cell("title_1", "<Title 1>") %>%
  set_cell("title_2", "<Title 2>") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn") %>%
  set_cell("watermark", "Draft")

print(g)

## -----------------------------------------------------------------------------
formula_object <- ~ barplot(1:10)

## -----------------------------------------------------------------------------
g <- gridify(object = formula_object, layout = complex_layout()) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer")

print(g)

## -----------------------------------------------------------------------------
# (to use `gridify` with flextables we require the function `as_grob()` to convert flextables into grob
# objects, which exists in versions >= 0.8.0 of `flextable`)

library(flextable)

ft <- flextable::flextable(head(mtcars[1:10]))

## ----fig.height = 5.5---------------------------------------------------------
g <- gridify(object = ft, layout = pharma_layout_letter()) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("output_num", "<Table> xx.xx.xx") %>%
  set_cell("title_1", "<Title 1>") %>%
  set_cell("title_2", "<Title 2>") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn") %>%
  print(g)

## -----------------------------------------------------------------------------
# (to use `gridify` with gt tables we require the function `as_gtable()` to convert gt tables into
# grob objects, which exists in versions >= 0.11.0 of `gt`)

library(gt)

gt_obj <- gt::gt(head(mtcars[1:10]))

## ----fig.height = 6-----------------------------------------------------------
g <- gridify(object = gt_obj, layout = pharma_layout_letter()) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("output_num", "<Table> xx.xx.xx") %>%
  set_cell("title_1", "<Title 1>") %>%
  set_cell("title_2", "<Title 2>") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn")

print(g)

## ----message = FALSE----------------------------------------------------------
library(rtables)
rtabl <- rtables::basic_table(main_footer = " ") %>%
  rtables::split_cols_by("Species") %>%
  rtables::analyze(
    c("Sepal.Length", "Sepal.Width", "Petal.Length"),
    function(x, ...) {
      rtables::in_rows(
        "Mean (sd)" = c(mean(x), stats::sd(x)),
        "Median" = median(x),
        "Min - Max" = range(x),
        .formats = c("xx.xx (xx.xx)", "xx.xx", "xx.xx - xx.xx")
      )
    }
  ) %>%
  rtables::build_table(iris)

## -----------------------------------------------------------------------------
library(rtables.officer)

ft <- rtables.officer::tt_to_flextable(rtabl, theme = NULL)

## -----------------------------------------------------------------------------
ft <- flextable::font(ft, fontname = "serif", part = "all")

## ----fig.width = 7, fig.height = 5.5------------------------------------------
g <- gridify(ft, layout = pharma_layout_A4()) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "PROJECT") %>%
  set_cell("header_left_3", "STUDY") %>%
  set_cell("header_right_1", "CONFIDENTIAL") %>%
  set_cell("header_right_2", "Draft") %>%
  set_cell("header_right_3", "Data Cut-off: 2000-01-01") %>%
  set_cell("output_num", "<Table> xx.xx.xx") %>%
  set_cell("title_1", "Summary Table for Iris Dataset") %>%
  set_cell("note", "Note") %>%
  set_cell("references", "References") %>%
  set_cell("footer_left", sprintf("Program: My Programme, %s at %s", Sys.Date(), format(Sys.time(), "%H:%M"))) %>%
  set_cell("footer_right", "Page 1 of 1") %>%
  set_cell("watermark", "DRAFT")

print(g)

## -----------------------------------------------------------------------------
fig_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(fig_obj, layout = simple_layout())

## ----eval = FALSE-------------------------------------------------------------
# show(g)

## -----------------------------------------------------------------------------
g

## -----------------------------------------------------------------------------
show_spec(g)

## -----------------------------------------------------------------------------
simple_layout()

## -----------------------------------------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(object = figure_obj, layout = complex_layout(global_gpar = grid::gpar(col = "navy", fontsize = 12))) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer")

## -----------------------------------------------------------------------------
g <- g %>%
  set_cell("header_right", "Right Header", gpar = grid::gpar(col = "purple", fontsize = 20))

print(g)

## -----------------------------------------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::theme(
    plot.background = ggplot2::element_rect(fill = "beige", colour = NA),  # Entire plot background
    panel.background = ggplot2::element_rect(fill = "beige", colour = NA),     # Panel (where data is plotted)
    panel.border = ggplot2::element_rect(colour = "black", fill = NA)
  ) +
  ggplot2::geom_line()

g <- gridify(figure_obj, layout = simple_layout(background = "beige")) %>%
  set_cell("title", "Title") %>%
  set_cell("footer", "Footer")

print(g)

## -----------------------------------------------------------------------------
figure_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

long_footer_string <- paste0(
  "This is a footer. We can have a long description here.",
  "We can have another long description here.",
  "We can have another long description here."
)

g <- gridify(figure_obj, layout = simple_layout()) %>%
  set_cell("title", "Title") %>%
  set_cell("footer", long_footer_string, mch = 45)

print(g)

## -----------------------------------------------------------------------------
g <- gridify(figure_obj, layout = simple_layout()) %>%
  set_cell("title", "Title") %>%
  set_cell("footer", long_footer_string, mch = 45, x = 0, hjust = 0, rot = 5)

print(g)

## -----------------------------------------------------------------------------
fixed_scales_g <- gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = complex_layout()
) %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("subtitle", "Subtitle", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("note", "Note", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("footer_left", "Left Footer", hjust = 1, vjust = 0.5, gpar = grid::gpar(fontsize = 10)) %>%
  set_cell("footer_middle", "Middle Footer", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("footer_right", "Right Footer", hjust = 0, vjust = 0.5, gpar = grid::gpar(fontsize = 10))

print(fixed_scales_g)

## -----------------------------------------------------------------------------
free_scales_g <- gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = complex_layout(scales = "free")
) %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("subtitle", "Subtitle", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("note", "Note", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("footer_left", "Left Footer", hjust = 1, vjust = 0.5, gpar = grid::gpar(fontsize = 10)) %>%
  set_cell("footer_middle", "Middle Footer", gpar = grid::gpar(fontsize = 30)) %>%
  set_cell("footer_right", "Right Footer", hjust = 0, vjust = 0.5, gpar = grid::gpar(fontsize = 10))

print(free_scales_g)

## ----fig.width = 10, fig.height = 8-------------------------------------------
print(free_scales_g)

## -----------------------------------------------------------------------------
g <- gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = complex_layout()
) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer")

print(g)

## -----------------------------------------------------------------------------
options(gridify.adjust_height.line = 0.7)

print(g)

## ----fig.width = 7, fig.height = 5--------------------------------------------
options(gridify.adjust_height.line = 0.1)

g <- gridify(
  object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
    ggplot2::geom_line(),
  layout = pharma_layout_letter()
) %>%
  set_cell("header_left_1", "My Company") %>%
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
  set_cell("header_left_3", "<STUDY>") %>%
  set_cell("header_right_2", "<Draft or Final>") %>%
  set_cell("output_num", "<Figure> xx.xx.xx") %>%
  set_cell("note", "<Note or Footnotes>") %>%
  set_cell("references", "<References:>") %>%
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
  set_cell("footer_right", "Page xx of nn")

print(g)

## ----fig.width = 7, fig.height = 5--------------------------------------------
options(gridify.adjust_height.line = 0.7)

print(g)

## ----eval = FALSE-------------------------------------------------------------
# gridify_obj <- gridify(
#   object = ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
#     ggplot2::geom_line(),
#   layout = pharma_layout_letter()
# ) %>%
#   set_cell("header_left_1", "My Company") %>%
#   set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
#   set_cell("header_left_3", "<STUDY>") %>%
#   set_cell("header_right_2", "<Draft or Final>") %>%
#   set_cell("output_num", "<Figure> xx.xx.xx") %>%
#   set_cell("title_1", "<Title 1>") %>%
#   set_cell("title_2", "<Title 2>") %>%
#   set_cell("note", "<Note or Footnotes>") %>%
#   set_cell("references", "<References:>") %>%
#   set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
#   set_cell("footer_right", "Page xx of nn") %>%
#   set_cell("watermark", "Draft")

## ----eval = FALSE-------------------------------------------------------------
# export_to(gridify_obj, to = "output.pdf")

## ----eval = FALSE-------------------------------------------------------------
# export_to(gridify_obj, to = "~/folder1/output.pdf")

## ----eval = FALSE-------------------------------------------------------------
# export_to(gridify_obj, to = "output.png")

## ----eval = FALSE-------------------------------------------------------------
# export_to(gridify_obj, to = "output.tiff")

## ----eval = FALSE-------------------------------------------------------------
# export_to(gridify_obj, to = "output.jpeg", width = 2400, height = 1800, res = 300)

