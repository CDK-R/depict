#' checkJavaClass
#'
#' check if an object is of a specified JavaClass
#'
#' @param jobj Required. A Java Object
#' @param klass Required. A string defining a java class
#' @return Boolean
checkJavaClass <- function(jobj, klass) {
  if (is.null(attr(jobj, 'jclass'))) stop("this is not a Java Object")
  attr(jobj, "jclass") == klass
}
