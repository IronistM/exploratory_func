context("test prophet functions")

test_that("do_prophet with aggregation", {
  data("raw_data", package = "AnomalyDetection")
  raw_data$timestamp <- as.POSIXct(raw_data$timestamp)
  raw_data <- raw_data %>% rename(`time stamp`=timestamp, `cou nt`=count)
  ret <- raw_data %>%
    do_prophet(`time stamp`, `cou nt`, 10, time_unit = "day")
  ret <- raw_data %>%
    do_prophet(`time stamp`, `cou nt`, 10, time_unit = "hour")
  ret <- raw_data %>% tail(100) %>%
    do_prophet(`time stamp`, `cou nt`, 10, time_unit = "minute")
  ret <- raw_data %>% tail(100) %>%
    do_prophet(`time stamp`, `cou nt`, 10, time_unit = "second")

  # test for test mode.
  raw_data$`cou nt`[[length(raw_data$`cou nt`) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `cou nt`, 2, time_unit = "day", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))

  ret <- raw_data %>%
    do_prophet(`time stamp`, `cou nt`, 2, time_unit = "hour", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))

  ret <- raw_data %>% tail(100) %>%
    do_prophet(`time stamp`, `cou nt`, 2, time_unit = "minute", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))

  ret <- raw_data %>% tail(100) %>%
    do_prophet(`time stamp`, `cou nt`, 2, time_unit = "second", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
})


# This test is too slow. TODO: make it faster and enable.
# test_that("do_prophet test mode with second as time units", {
#   ts <- seq(as.POSIXct("2010-01-01:00:00:00"), as.POSIXct("2010-01-3:00:00"), by="sec")
#   raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
#   raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
#   ret <- raw_data %>%
#     do_prophet(`time stamp`, `da ta`, 10, time_unit = "second", test_mode=TRUE)
#   # verify that the last forecasted_value is not NA to test #9211
#   expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
#   # verify that daily, weekly is enabled to test #9361.
#   expect_equal(c("daily") %in% colnames(ret),c(T))
# })

# This test is slow. TODO: make it faster.
test_that("do_prophet test mode with minute as time units", {
  ts <- seq(as.POSIXct("2010-01-01:00:00:00"), as.POSIXct("2010-01-15:00:00"), by="min")
  raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
  raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `da ta`, 10, time_unit = "minute", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
  # verify that daily, weekly is enabled to test #9361.
  expect_equal(c("daily","weekly") %in% colnames(ret),c(T,T))
})

test_that("do_prophet test mode with hour as time units", {
  ts <- seq(as.POSIXct("2010-01-01:00:00:00"), as.POSIXct("2010-01-15:00:00"), by="hour")
  raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
  raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `da ta`, 10, time_unit = "hour", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
  # verify that daily, weekly is enabled to test #9361.
  expect_equal(c("daily","weekly") %in% colnames(ret),c(T,T))
})

test_that("do_prophet test mode with month as time units", {
  ts <- seq.Date(as.Date("2010-01-01"), as.Date("2030-01-01"), by="month")
  raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
  raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `da ta`, 10, time_unit = "month", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
})

test_that("do_prophet test mode with quarter as time units", {
  ts <- seq.Date(as.Date("2010-01-01"), as.Date("2030-01-01"), by="quarter")
  raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
  raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `da ta`, 10, time_unit = "quarter", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
})

test_that("do_prophet test mode with year as time units", {
  ts <- seq.Date(as.Date("2010-01-01"), as.Date("2030-01-01"), by="year")
  raw_data <- data.frame(timestamp=ts, data=runif(length(ts))) %>% dplyr::rename(`time stamp`=timestamp, `da ta`=data)
  raw_data$`da ta`[[length(ts) - 2]] <- NA # inject NA near the end to test #9211
  ret <- raw_data %>%
    do_prophet(`time stamp`, `da ta`, 10, time_unit = "year", test_mode=TRUE)
  # verify that the last forecasted_value is not NA to test #9211
  expect_true(!is.na(ret$forecasted_value[[length(ret$forecasted_value)]]))
})


test_that("do_prophet grouped case", {
  data("raw_data", package = "AnomalyDetection")
  raw_data$timestamp <- as.POSIXct(raw_data$timestamp)
  expect_error({
    ret <- raw_data %>%
      dplyr::group_by(timestamp) %>%
      do_prophet(timestamp, count, 10)
  }, "timestamp is grouped. Please ungroup it.")

  expect_error({
    ret <- raw_data %>%
      dplyr::group_by(count) %>%
      do_prophet(timestamp, count, 10)
  }, "count is grouped. Please ungroup it.")
})

test_that("do_prophet without value_col", {
  data("raw_data", package = "AnomalyDetection")
  raw_data$timestamp <- as.POSIXct(raw_data$timestamp)
  ret <- raw_data %>%
    do_prophet(timestamp, NULL, 10)
})
