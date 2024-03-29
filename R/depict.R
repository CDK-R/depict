#' depiction
#'
#' create the CDK depiction object that can be manipulated
#'
#' @return DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @export
depiction <- function() {
  .jnew("org/openscience/cdk/depict/DepictionGenerator")
}

#' color atoms
#'
#' set the atom color
#'
#' @param dg a CDK DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @return DepictionGenerator
#' @export
color_atoms <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("color_atoms requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withAtomColors")
}

#' outerglow
#'
#' @param dg a CDK Depiction Generator
#' @return DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @export
outerglow <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("outerglow requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withOuterGlowHighlight")
}

#' set_size
#'
#' @param dg a CDK Depiction Generator
#' @param width width (int)
#' @param height height  (int)
#' @return DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @export
set_size <- function(dg, width, height) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("set_size requires a Depiction Generator")
  }

  dg$withSize(width, height)
}

#' add_title
#'
#' @param dg a CDK  Depiction Generator
#' @return DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @export
add_title <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_title requires a Depiction Generator")
  }

  dg$withMolTitle()
}

#' add terminal carbons
#'
#' @param dg a Depiction Generator
#' @return DepictionGenerator
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/DepictionGenerator.html}
#' @export
add_terminal_carbons <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_terminal_carbons requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withTerminalCarbons")
}



#' depict
#'
#' Depict a molecule using the depiction generator. Display options are set on
#' the Generator. This function applies those settings to a given molecule or set
#' of molecules.
#'
#' @param dg Required. A DepictionGenerator
#' @param mol Required. An AtomContainer
#' @return A Depiction
#' @seealso \url{https://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/depict/Depiction.html}
#' @export
depict <- function(dg, mol) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    print(.jclass(dg))
    stop("depict requires a Depiction Generator")
  }

  if (!checkJavaClass(mol, c(
    "org/openscience/cdk/AtomContainer",
    "org/openscience/cdk/AtomContainer2",
    "org/openscience/cdk/Reaction",
    "org/openscience/cdk/ReactionSet",
    "org/openscience/cdk/silent/AtomContainer",
    "org/openscience/cdk/silent/AtomContainer2",
    "org/openscience/cdk/silent/IAtomContainer",
    "org/openscience/cdk/silent/Reaction",
    "org/openscience/cdk/silent/ReactionSet",
    "java/util/ArrayList"
  ))) {
    stop("depict requires an AtomContainer, Reaction, ReactionSet, or an ArrayList of them")
  }

  # .jcall(dg, "Lorg/openscience/cdk/depict/Depiction;", "depict", mol)
  dg$depict(mol)
}

#' highlight_atoms
#'
#' Highlight atoms
#'
#' @param dg Required. A Depiction Generator
#' @param atoms Required. A list of CDK IChemOjbects, usually atoms or bonds
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
#' save image to disk
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @param outfile Required. Filepath to the output
#' @export
save_image <- function(molgrid, outfile) {
  if (!checkJavaClass(molgrid, c(
    "org/openscience/cdk/depict/MolGridDepiction",
    "org/openscience/cdk/depict/ReactionDepiction"
  ))) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  molgrid$writeTo(outfile)
}

#' get_image
#'
#' get image
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @importFrom png readPNG
#' @export
#'
get_image <- function(molgrid) {
  if (!checkJavaClass(molgrid, c(
    "org/openscience/cdk/depict/MolGridDepiction",
    "org/openscience/cdk/depict/ReactionDepiction"
  ))) {
    print(.jclass(molgrid))
    stop("get_image requires a Depiction")
  }

  # CDK apends a ".png" to the name
  output <- paste(tempfile(), "png")
  output1 <- paste0(output, ".png")

  molgrid$writeTo("png", output)
  img <- readPNG(output1)

  unlink(output)
  unlink(output1)

  img
}

#' get_svg_string
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @returns an SVG string literal
#' @export
get_svg_string <- function(molgrid) {
  if (!checkJavaClass(molgrid, c(
    "org/openscience/cdk/depict/MolGridDepiction",
    "org/openscience/cdk/depict/ReactionDepiction"
  ))) {
    print(.jclass(molgrid))
    stop("get_image requires a Depiction")
  }
  
  # svg_str <- grid$toSvgStr()
  svg_str <- .jcall(molgrid, 'S' ,'toSvgStr')
  
  svg_list <- strsplit(svg_str, "\n")[[1]]
  
  # return the svg without the two header lines
  paste(svg_list[3:length(svg_list)], collapse="\n")
}


#' set_zoom
#'
#' set_zoom
#'
#' @param dg a Depiction Generator
#' @param zoom Optional. Default \code{1}
#' @return DepictionGenerator
#' @export
#'
set_zoom <- function(dg, zoom = 1) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  dg$withZoom(zoom)
}
