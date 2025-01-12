# Function to skip tests if Suggested packages not available on system
check_suggests <- function() {
  skip_if_not_installed("rvest")
  skip_if_not_installed("xml2")

}

padded_tab <- data.frame(numbers = c(1.2345, 12.345, 123.45, 1234.5, 12345)) %>%
  gt() %>%
  fmt_pad_num(columns = numbers, nsmall = 4)

pad_html <- padded_tab %>%
  gt::as_raw_html() %>%
  rvest::read_html() %>%
  rvest::html_nodes("td:nth-child(1)") %>%
  rvest::html_text()

  pad_vec <- c("    1.2345", "   12.345&nbsp", "  123.45&nbsp&nbsp",
               " 1234.5&nbsp&nbsp&nbsp", "12345.&nbsp&nbsp&nbsp&nbsp")

test_that("gt_fmt_pad_num test that padding is correct", {
  check_suggests()

  expect_equal(pad_html, pad_vec)

})
