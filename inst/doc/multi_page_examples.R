## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 7,
  fig.height = 4
)

## -----------------------------------------------------------------------------
library(gridify)
library(magrittr)
library(ggplot2)

## -----------------------------------------------------------------------------
figures_data <- list(
  global = list(
    project = "My Project",
    indication = "My Indication",
    study = "My Study",
    cutoff = "Data Cut-off: YYYY-MM-DD",
    program = "program1.R",
    var1 = "mpg",
    note1 = "Note: Violin figure: compact display of continuous distribution; it is a blend of boxplot and density,
    the latter based on a Gaussian kernel estimator.",
    note2 = "Note: Placebo subjects switched to Study Drug at/after Week 16.",
    note3 = "Note: Total Study Drug includes subjects randomized to Placebo and to Study Drug.",
    note4 = "Note: N denotes the treatment population and n denotes the contributing population for
    the analysis for each treatment, parameter and visit"
  ),
  figures = list(
    figure1 = list(
      number = "1.1",
      title1 = "My title Group A",
      title2 = "My title 2",
      var2 = "wt"
    ),
    figure2 = list(
      number = "1.2",
      title1 = "My Title Group B",
      title2 = "My title 2",
      var2 = "cyl"
    )
  )
)

## ----eval = FALSE-------------------------------------------------------------
# library(readxl)
# 
# dat <- readxl::read_excel("PATH TO YOUR FILE")
# figures <- lapply(seq_len(nrow(dat)), function(row) dat[row, ])
# # Optionally, you can add names to the elements of 'figures' so you won't have to subset by index later
# names(figures) <- paste0("figure", seq_along(figures))
# # Alternatively, you can leave the 'dat' object as it is and loop through its rows,
# # or with row names if available

## -----------------------------------------------------------------------------
generate_figure <- function(data, var1, var2) {
  ggplot2::ggplot(data, ggplot2::aes(x = !!as.name(var1), y = !!as.name(var2))) +
    ggplot2::geom_line()
}

## -----------------------------------------------------------------------------
figures_list <- list()

## -----------------------------------------------------------------------------
COMPANY <- "My Company"
STATUS <- "DRAFT"

## -----------------------------------------------------------------------------
for (figure_index in seq_along(figures_data$figures)) {
  figure_obj <- generate_figure(mtcars, figures_data$global$var1, figures_data$figures[[figure_index]]$var2)

  # Add text elements using `sprintf()`
  gridify_obj <- gridify(
    object = figure_obj,
    layout = pharma_layout_A4()
  ) %>%
    # Add STATIC text elements to the `gridify` object
    # You can define these values as variables at the top of your script
    set_cell("header_left_1", COMPANY) %>%
    set_cell("watermark", toupper(STATUS)) %>%
    set_cell("header_right_2", STATUS) %>%
    # Add VARIABLE text elements to the gridify object
    set_cell("header_left_2", sprintf("%s / %s", figures_data$global$project, figures_data$global$indication)) %>%
    set_cell("header_left_3", figures_data$global$study) %>%
    set_cell("header_right_3", sprintf("%s", figures_data$global$cutoff)) %>%
    set_cell("output_num", sprintf("Output %s", figures_data$figures[[figure_index]]$number)) %>%
    set_cell("title_1", figures_data$figures[[figure_index]]$title1) %>%
    set_cell("title_2", figures_data$figures[[figure_index]]$title2) %>%
    set_cell("note", paste(figures_data$global[c("note1", "note2", "note3", "note4")], collapse = "\n")) %>%
    set_cell("footer_left", sprintf("Program: %s, %s", figures_data$global$program, Sys.time())) %>%
    set_cell("footer_right", sprintf("Page %s of %s", figure_index, length(figures_data$figures)))

  figures_list[[figure_index]] <- gridify_obj
}

## ----eval = FALSE-------------------------------------------------------------
# if (!dir.exists("figures")) {
#   dir.create("figures")
# }

## ----eval = FALSE-------------------------------------------------------------
# export_to(
#   figures_list,
#   sprintf("./figures/test_Company_A4_layout_%s.pdf", seq_along(figures_list))
# )

## ----eval = FALSE-------------------------------------------------------------
# export_to(
#   figures_list,
#   "./figures/test_multi_Company_A4_layout.pdf"
# )

## -----------------------------------------------------------------------------
library(gt)

## -----------------------------------------------------------------------------
table_cols <- c("cyl", "vs", "am", "drat", "qsec") # Columns that appear in final output
df <- mtcars[, table_cols]
rows_per_page <- 10

# Use the helper function to split the table
pages <- paginate_table(
  df,
  rows_per_page = rows_per_page,
  fill_empty = " "  # Optional: fills last page with a string for consistent positioning
)

number_of_pages <- length(pages)

## ----fig.width=7.2, fig.height=7----------------------------------------------
# Define styling parameters
row_height_pixels <- 10
font_size <- 12
font_type <- "serif"

results_list <- list()
for (iter in seq_along(pages)) {
  gt_input <- gt(pages[[iter]]) %>%
    tab_options(
      table.width = pct(80),
      data_row.padding = px(row_height_pixels),
      page.numbering = TRUE,
      table.font.size = font_size,
      table.font.names = font_type
    )

  results_list[[iter]] <- gridify(
    gt_input,
    layout = pharma_layout_A4(global_gpar = grid::gpar(fontfamily = font_type))
  ) %>%
    set_cell("header_left_1", "My Company") %>%
    set_cell("header_left_2", "<PROJECT> / <INDICATION>") %>%
    set_cell("header_left_3", "<STUDY>") %>%
    set_cell("header_right_1", "CONFIDENTIAL") %>%
    set_cell("header_right_2", "<Draft or Final>") %>%
    set_cell("header_right_3", "Data Cut-off: YYYY-MM-DD") %>%
    set_cell("output_num", "<Output> xx.xx.xx") %>%
    set_cell("title_1", "<Title 1>") %>%
    set_cell("title_2", "<Title 2>") %>%
    set_cell("title_3", "<Optional Title 3>") %>%
    set_cell("note", "<Note or Footnotes>") %>%
    set_cell("references", "<References:>") %>%
    set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") %>%
    set_cell("footer_right", paste0("Page ", iter, " of ", number_of_pages)) %>%
    set_cell("watermark", "DRAFT")
}

print(results_list[[1]])

## ----eval = FALSE-------------------------------------------------------------
# if (!dir.exists("tables")) {
#   dir.create("tables")
# }

## ----eval = FALSE-------------------------------------------------------------
# export_to(
#   results_list,
#   to = "./tables/multipageA4.pdf"
# )
# 
# export_to(
#   results_list,
#   to = "./tables/multipageA4portrait.pdf",
#   width = 8.3,
#   height = 11.7
# )

## ----eval = FALSE-------------------------------------------------------------
# export_to(
#   results_list[[1]],
#   to = "./tables/singlepage.png",
#   width = 2400,
#   height = 2000,
#   res = 300
# )
# 
# export_to(
#   results_list[[1]],
#   to = "./tables/singlepage.jpg",
#   width = 2400,
#   height = 2000,
#   res = 300
# )

## ----eval = FALSE-------------------------------------------------------------
# export_to(
#   results_list,
#   to = file.path("./tables", sprintf("singlepage%s.png", seq_along(results_list))),
#   width = 2400,
#   height = 2000,
#   res = 300
# )
# 
# export_to(
#   results_list,
#   to = file.path("./tables", sprintf("singlepage%s.jpg", seq_along(results_list))),
#   width = 2400,
#   height = 2000,
#   res = 300
# )
# 
# export_to(
#   results_list,
#   to = file.path("./tables", sprintf("singlepage%s.pdf", seq_along(results_list))),
#   width = 2400,
#   height = 2000,
#   res = 300
# )

## ----fig.width = 7.2, fig.height = 45-----------------------------------------
gt_obj <- gt::gt(Theoph)

g <- gridify(
  object = gt_obj,
  layout = pharma_layout_letter()
) %>%
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

