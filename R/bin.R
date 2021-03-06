binSize <- function(data, col, group = NULL, panel = NULL, binWidth = NULL) {
  aggStr <- getAggStr(col, c('binLabel', 'binStart', group, panel))

  data$binLabel <- bin(data[[col]], binWidth)
  data$binStart <- findBinStart(data$binLabel)

  dt <- aggregate(as.formula(aggStr), data, length)
  dt <- noStatsFacet(dt, group, panel)
  names(dt) <- c(group, panel, 'binLabel', 'binStart', 'value')

  return(dt)
}

binProportion <- function(data, col, group = NULL, panel = NULL, binWidth = NULL) {
  aggStr <- getAggStr(col, c('binLabel', 'binStart', group, panel))
  aggStr2 <- getAggStr(col, c(group, panel))

  data$binLabel <- bin(data[[col]], binWidth)
  data$binStart <- findBinStart(data$binLabel)

  dt <- aggregate(as.formula(aggStr), data, length)
  if (is.null(group) && is.null(panel)) {
    dt$denom <- length(data[[col]])
    dt <- data.table::data.table('binLabel' = list(dt$binLabel), 'binStart' = list(dt$binStart), 'value' = list(dt[col]/dt$denom))
  } else {
    dt2 <- aggregate(as.formula(aggStr2), data, length)
    names(dt2) <- c(group, panel, 'denom')
    mergeByCols <- c(group, panel)
    dt <- merge(dt, dt2, by = mergeByCols)
    dt[[col]] <- dt[[col]]/dt$denom
    dt$denom <- NULL
    dt <- noStatsFacet(dt, group, panel)
    names(dt) <- c(group, panel, 'binLabel', 'binStart', 'value')
  }

  return(dt)
}
