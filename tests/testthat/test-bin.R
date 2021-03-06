context('bin')

test_that("binProportion() returns an appropriately sized data.table", {
  dt <- binProportion(data.xy,'y', binWidth=.1)
  expect_is(dt, 'data.table')
  expect_equal(nrow(dt),1)
  expect_equal(names(dt), c('binLabel', 'binStart', 'value'))

  dt <- binProportion(data.xy, 'y','group', binWidth=.1)
  expect_is(dt, 'data.table')
  expect_equal(nrow(dt),4)
  expect_equal(names(dt), c('group', 'binLabel', 'binStart', 'value'))

  dt <- binProportion(data.xy, 'y', NULL, 'panel', binWidth=.1)
  expect_is(dt, 'data.table')
  expect_equal(nrow(dt),4)
  expect_equal(names(dt), c('panel', 'binLabel', 'binStart', 'value'))

  dt <- binProportion(data.xy, 'y', 'group', 'panel', binWidth=.1)
  expect_is(dt, 'data.table')
  expect_equal(nrow(dt),16)
  expect_equal(names(dt), c('group', 'panel', 'binLabel', 'binStart', 'value'))

})

test_that("binProportion() returns consistent results", {
  dt <- binProportion(data.xy,'y', binWidth=.1)
  expect_equal_to_reference(dt,"proportion.rds")
  dt <- binProportion(data.xy, 'y','group', binWidth=.1)
  expect_equal_to_reference(dt,"proportion.group.rds")
  dt <- binProportion(data.xy, 'y', NULL, 'panel', binWidth=.1)
  expect_equal_to_reference(dt,"proportion.panel.rds")
  dt <- binProportion(data.xy, 'y', 'group', 'panel', binWidth=.1)
  expect_equal_to_reference(dt,"proportion.group.panel.rds")  
})
