#' amino_acids
#'
#' return a named list of SMARTS
#' patterns for amino_acids
#'
#' @seealso \url{http://www.daylight.com/dayhtml/doc/theory/theory.smarts.html}
#' @seealso \url{http://www.daylight.com/dayhtml_tutorials/languages/smarts/index.html}
#' @export
#'
#'
amino_acids <- function() {
  list(
    # Generic amino acid: low specificity.
    amino_acids = "[NX3,NX4+][CX4H]([*])[CX3](=[OX1])[O,N]", # For use w/ non-standard a.a. search. hits pro but not gly. Hits acids and conjugate bases. Hits single a.a.s and specific residues w/in polypeptides (internal, or terminal).

    # A.A. Template for 20 standard a.a.s
    amino_acids20 = "[$([$([NX3H,NX4H2+]),$([NX3](C)(C)(C))]1[CX4H]([CH2][CH2][CH2]1)[CX3](=[OX1])[OX2H,OX1-,N]),
    $([$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H2][CX3](=[OX1])[OX2H,OX1-,N]),$([$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H]([*])[CX3](=[OX1])[OX2H,OX1-,N])]",
    proline = "[$([NX3H,NX4H2+]),$([NX3](C)(C)(C))]1[CX4H]([CH2][CH2][CH2]1)[CX3](=[OX1])[OX2H,OX1-,N]",
    glycine = "[$([$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H2][CX3](=[OX1])[OX2H,OX1-,N])]",
    amino_acids18 = "[$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H]([*])[CX3](=[OX1])[OX2H,OX1-,N]",
    alanine = "[$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H]([CH3X4])[CX3](=[OX1])[OX2H,OX1-,N]",

    # $([CH2X4][CX3](=[OX1])[NX3H2]),
    # $([CH2X4][CX3](=[OX1])[OH0-,OH]),
    # $([CH2X4][SX2H,SX1H0-]),
    # $([CH2X4][CH2X4][CX3](=[OX1])[OH0-,OH]),
    # $([CH2X4][#6X3]1:[$([#7X3H+,#7X2H0+0]:[#6X3H]:[#7X3H]),$([#7X3H])]:[#6X3H]:[$([#7X3H+,#7X2H0+0]:[#6X3H]:[#7X3H]),$([#7X3H])]:[#6X3H]1),
    #   $([CHX4]([CH3X4])[CH2X4][CH3X4]),
    #   $([CH2X4][CHX4]([CH3X4])[CH3X4]),
    #   $([CH2X4][CH2X4][CH2X4][CH2X4][NX4+,NX3+0]),
    #   $([CH2X4][CH2X4][SX2][CH3X4]),
    #   $([CH2X4][cX3]1[cX3H][cX3H][cX3H][cX3H][cX3H]1),
    #   $([CH2X4][OX2H]),
    #   $([CHX4]([CH3X4])[OX2H]),
    #   $([CH2X4][cX3]1[cX3H][nX3H][cX3]2[cX3H][cX3H][cX3H][cX3H][cX3]12),
    #   $([CH2X4][cX3]1[cX3H][cX3H][cX3]([OHX2,OH0X1-])[cX3H][cX3H]1),
    #   $([CHX4]([CH3X4])[CH3X4])
    amino_acids18 = "[$([NX3H2,NX4H3+]),$([NX3H](C)(C))][CX4H]([*])[CX3](=[OX1])[OX2H,OX1-,N]"
  )
}
