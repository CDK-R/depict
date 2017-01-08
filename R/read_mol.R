#' read_mol
#'
#' Read a Molfile and return an AtomContainer Object
#'
#' @param molfile Required. A filepath to a MOLfile.
#' @return an AtomContainer
#' @export
read_mol <- function(molfile) {
  jfile          <- J("java.io.File")
  jfreader       <- J("java.io.FileReader")
  jAtomContainer <- J("org.openscience.cdk.AtomContainer")
  jMDLreader     <- J("org.openscience.cdk.io.MDLV2000Reader")

  jfileobj   <- new(jfile, molfile)
  jreaderobj <- new(jfreader, jfileobj)
  jmolreader <- new(jMDLreader, jreaderobj)

  jmolreader$read(new(jAtomContainer))
}

