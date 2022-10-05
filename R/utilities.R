#' checkJavaClass
#'
#' check if an object is of a specified JavaClass
#'
#' @param jobj Required. A Java Object
#' @param klass Required. A string defining a java class
#' @return Boolean
checkJavaClass <- function(jobj, klass ) {
  if (is.null(attr(jobj, 'jclass'))) stop("this is not a Java Object")

  for (k in klass ) {
    if (attr(jobj, "jclass") == k) {
      return(TRUE)
    }
  }
  return(FALSE)
}




#' atomcontainer_list_to_jarray
#'
#'
#' @param atomcontainers
#' @return a java ArrayList of AtomContainers
#' 
#' @export
#' @examples 
#' \dontrun {
#' 
#' atmcontnrs <- purrr::map(
#'      c("CCCCCC", "CCC1CCC1NC", "COCCOCCO")
#'      parse_smiles)
#'      
#' atomcontainer_list_to_jarray(atmcontnrs)
#' 
#' }
#' 
atomcontainer_list_to_jarray <- function(atomcontainers) {
  
  new_array <-  .jnew('java.util.ArrayList')
  
  for (atmcntnr in atomcontainers) {
    new_array$add(atmcntnr)
  }
  
  new_array
}
