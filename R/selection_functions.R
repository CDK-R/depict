#' match SMARTs
#'
#' @param smarts
#' @param mol
#' @param limit
#'
#' @return a hashset of atoms and bonds
#' @export
#'
match_smarts <- function(smarts, mol, limit=10) {
  hashset       <- J("java/util/HashSet")
  smartspattern <- J("org/openscience/cdk/smiles/smarts/SmartsPattern")
  spattern      <- smartspattern$create(smarts, NULL)

  #spattern$matchAll(mol)$limit(limit)$uniqueAtoms()$toAtomBondMap()
  matches <- spattern$matchAll(mol)
  #matches <- matches$limit(10L)
  atombondmap <- matches$uniqueAtoms()$toAtomBondMap()

  # somewhat convoluted code to get all of the matching atoms
  highlight <- new(hashset)

  for (l in as.list(atombondmap)) {
    newset <- l$entrySet()
    newset <- as.list(newset)
    for (x in newset) {
      highlight$add(x$getValue())
    }
  }
  highlight
}

