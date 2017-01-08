#' depiction
#'
#' create the CDK depiction object that can be manipulated
#'
#' @export
depiction <- function() {
  DepictionGenerator <- J("org/openscience/cdk/depict/DepictionGenerator")
  new(DepictionGenerator)
}
#' color atoms
#'
#' @param dg
#' @export
color_atoms <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("color_atoms requires a Depiction Generator")
  }

  dg$withAtomColors()
}
#' outerglow
#'
#' @param dg
#' @param a Depiction Generator
#' @export
outerglow <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("outerglow requires a Depiction Generator")
  }

  dg$withOuterGlowHighlight()
}
#' set_size
#'
#' @param dg
#' @param width
#' @param height
#' @param a Depiction Generator
#' @export
set_size <- function(dg, width, height) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("set_size requires a Depiction Generator")
  }
  dg$withSize(width,height)
}
#' add_title
#'
#' @param dg
#' @param a Depiction Generator
#' @export
add_title <- function(dg) {

  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_title requires a Depiction Generator")
  }

  dg$withMolTitle()
}
#' add terminal carbons
#'
#' @param dg
#' @param a Depiction Generator
#' @export
add_terminal_carbons <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_terminal_carbons requires a Depiction Generator")
  }

  dg$withTerminalCarbons()
}

#' zoom
#'
#' @param dg
#' @param zoom
#' @param a Depiction Generator
#' @export
add_terminal_carbons <- function(dg, zoom=1) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_terminal_carbons requires a Depiction Generator")
  }

  dg$withZoom(zoom)
}
#' depict
#'
#' depict a molecule using the depiction generator.
#'
#' @param dg Required. A Depiction Generator
#' @param mol Required. An AtomContainer
#' @export
depict <- function(dg, mol) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("depict requires a Depiction Generator")
  }

  if (!checkJavaClass(mol, "org/openscience/cdk/AtomContainer")) {
    stop("depict requires a Depiction Generator")
  }

  dg$depict(mol)
}
#' highlight_atoms
#'
#' Highlight atoms
#'
#' @param dg Required. A Depiction Generator
#' @param highlights Required. A list of CDK IOBJects, usually atoms or bonds
#' @param color Required. A java.awt.Color
#' @export
highlight_atoms <- function(dg, atoms, color) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  dg$withHighlight(atoms, color)
}
#' save_image
#'
#' Highlight atoms
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @param outfile Required. Filepath to the output
#' @export
save_image <- function(molgrid, filepath) {
  if (!checkJavaClass(molgrid, "org/openscience/cdk/depict/MolGridDepiction")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  molgrid$writeTo(filepath)
}
