#' parse_smiles
#'
#' simple smiles parser
#'
#' @param smi Required. A smiles string
#' @param generatecoords Optional. Default \code{TRUE}. Whether
#'  to generate coordinates from the smiles
#' @export
#'
parse_smiles <- function(smi, generatecoords=TRUE) {

  SmilesParser <- J("org.openscience.cdk.smiles.SmilesParser")
  SChemObjectBuilder <- J("org.openscience.cdk.silent.SilentChemObjectBuilder")
  StructureDiagramGenerator <- J("org.openscience.cdk.layout.StructureDiagramGenerator")

  sinst <- SChemObjectBuilder$getInstance()
  sp    <- new(SmilesParser, sinst)
  mol   <- sp$parseSmiles(smi)

  if (generatecoords) {
    sdg   <- new(StructureDiagramGenerator)
    sdg$setMolecule(mol)
    sdg$generateCoordinates()
    mol <- sdg$getMolecule()
  }

  mol

}

#' read_mol
#'
#' Read a Molfile and return an AtomContainer
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

