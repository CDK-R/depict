#' select_all_atoms_bonds
#'
#' depict a molecule using the depiciotn generator.
#'
#' @param dg Required. A Depiciton Generator
#' @param location Required. A filepath
#' @export
select_all_atoms_bonds <- function(mol) {

  if (!checkJavaClass(dg, "org/openscience/cdk/depict/MolGridDepiction")) {
    stop("save_image requires a Depiction Generator")
  }

  dg$writeTo(location)
}




