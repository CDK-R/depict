#' match_smarts
#'
#' Find matches to a given molecule using a SMARTs pattern.
#'
#' @param smarts a SMARTS string
#' @param mol a CDK IAtomContainer or a java.util.Arraylist of them
#' @param limit limit of the number of matches
#'
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/isomorphism/Mappings.html}
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/smiles/smarts/SmartsPattern.html}
#'
#' @return a hashset of atoms and bonds
#' @export
#'
#'
match_smarts <- function(smarts, mol, limit = 10) {
  hashset <- J("java/util/HashSet")
  smartspattern <- J("org/openscience/cdk/smiles/smarts/SmartsPattern")
  spattern <- smartspattern$create(smarts, NULL)

  # handle the base case first
  if (!.jclass(mol) == "java.util.ArrayList") {
    matches <- spattern$matchAll(mol)
    matches <- matches$limit(as.integer(limit))
    # Note: switching below to chemobjects due to reflection access with the atom-bond map
    # atombondmap <- matches$uniqueAtoms()$toAtomBondMap()
    atombonds <- matches$uniqueAtoms()$toChemObjects()

    # somewhat convoluted code to get all of the matching atoms
    highlight <- new(hashset)

    for (l in as.list(atombonds)) {
      highlight$add(l)
    }

    # then handle the array list of atom containers
  } else {
    # somewhat convoluted code to get all of the matching atoms
    highlight <- new(hashset)

    for (atmcont in as.list(mol)) {
      matches <- spattern$matchAll(atmcont)
      matches <- matches$limit(as.integer(limit))
      # Note: switching below to chemobjects due to reflection access with the atom-bond map
      # atombondmap <- matches$uniqueAtoms()$toAtomBondMap()
      atombonds <- matches$uniqueAtoms()$toChemObjects()
      for (l in as.list(atombonds)) {
        highlight$add(l)
      }
    }
  }

  highlight
}
