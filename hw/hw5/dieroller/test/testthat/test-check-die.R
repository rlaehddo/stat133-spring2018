context("Check die arguments")

test_that("check_sides with ok vectors", {
  
  expect_true(check_sides(c(1, 2, 3, 4, 5, 6)))
  expect_true(check_sides(letters[1:6]))
})


test_that("check_sides fails with invalid lengths", {
  
  expect_error(check_sides(c('one', 'two', 'three')))
  expect_error(check_sides(c('one')))
  expect_error(check_sides(1:5))
  expect_error(check_sides(1))
})


test_that("check_prob works with ok vectors", {
  
  expect_true(check_prob(rep(1/6, 6)))
  expect_true(check_prob(c(0.1, 0.1, 0.2, 0.2, 0.35, 0.05)))
  expect_true(check_prob(c(1, 0, 0, 0, 0, 0)))
  expect_true(check_prob(c(0.1, 0, 0, 0, 0, 0.9)))
})


test_that("check_prob fails with invalid lengths", {
  
  expect_error(check_prob(1:5))
  expect_error(check_prob(1))
})


test_that("check_prob fails with invalid numbers", {
  
  expect_error(check_prob(rep(1/5, 6)))
  expect_error(check_prob(c(0.1, 0.1, 0.2, 0.2, 0.35, 0.1)))
  expect_error(check_prob(c(rep(0.5, 6))))
  expect_error(check_prob(c(0.1, 0.1, 0.2, 0.2, 0.35, NA)))
})

