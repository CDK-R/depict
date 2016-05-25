#' Draw A Molecule and Write it to File
#'
#' Use CDK's depict module to draw a molecule
#'
#' @param mol a CDK AtomContainer
#' @export
#' @examples
#' mols <- rcdk::parse.smiles("CCC1CCCNNNCCCC1NCN")
#' mol <- mols[[1]]
#' depict(mol, imgoutfile="example1.png",zoom=4)
#'
depict <- function(mol, imgoutfile,
                   sizex=NULL,
                   sizey=NULL,
                   type="png",
                   atomcolors=TRUE,
                   moltitle=TRUE,
                   outerglow=TRUE,
                   terminalcarbons = FALSE,
                   zoom=1) {

  # check to see if mols are
  DepictionGenerator <- J("org.openscience.cdk.depict.DepictionGenerator")

  dg <- new(DepictionGenerator)

  if (!(is.null(sizex) || is.null(sizey))) {
    dg <-dg$withSize(sizex,sizey)
    }
  if (atomcolors == TRUE)       {dg <- dg$withAtomColors()}
  if (outerglow  == TRUE)       {dg <- dg$withOuterGlowHighlight()}
  if (moltitle  == TRUE)        {dg <- dg$withMolTitle()}
  if (terminalcarbons  == TRUE) {dg <- dg$withTerminalCarbons()}

  dg <- dg$withZoom(zoom)

  # draw the mol
  dg$depict(mol)$writeTo(imgoutfile)
}
