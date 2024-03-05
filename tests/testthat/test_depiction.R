library("testthat")
library("depict")

context("Test Depiction")

test_that("we can depict a molecule", {
  # load in penicillin
  pen <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
  cav <- parse_smiles("CN1C=NC2=C1C(=O)N(C(=O)N2C)C")

  atomcontainerclasses <- c(
    "org/openscience/cdk/AtomContainer2",
    "org/openscience/cdk/AtomContainer",
    "org/openscience/cdk/silent/AtomContainer2",
    "org/openscience/cdk/silent/AtomContainer",
    "org/openscience/cdk/IAtomContainer"
  )

  expect_true(attr(pen, "jclass") %in% atomcontainerclasses)
  expect_true(attr(cav, "jclass") %in% atomcontainerclasses)

  dep <- depiction() |> depict(pen)
  expect_equal(attr(dep, "jclass"), "org/openscience/cdk/depict/MolGridDepiction")

  img <- get_image(dep)
  expect_true(inherits(img, "array"))
})


test_that("we can depict a moleculeset", {
  # 
  # 
  # multi_smiles <- "ClC1=NC=2N(C(=C1)N(CC3=CC=CC=C3)CC4=CC=CC=C4)N=CC2C(OCC)=O>C1(=CC(=CC(=N1)C)N)N2C[C@H](CCC2)O.O1CCOCC1.CC1(C2=C(C(=CC=C2)P(C3=CC=CC=C3)C4=CC=CC=C4)OC5=C(C=CC=C15)P(C6=CC=CC=C6)C7=CC=CC=C7)C.C=1C=CC(=CC1)\\C=C\\C(=O)\\C=C\\C2=CC=CC=C2.C=1C=CC(=CC1)\\C=C\\C(=O)\\C=C\\C2=CC=CC=C2.C=1C=CC(=CC1)\\C=C\\C(=O)\\C=C\\C2=CC=CC=C2.[Pd].[Pd].[Cs]OC(=O)O[Cs]>C1(=CC(=CC(=N1)C)NC2=NC=3N(C(=C2)N(CC4=CC=CC=C4)CC5=CC=CC=C5)N=CC3C(OCC)=O)N6C[C@H](CCC6)O>CO.C1CCOC1.O.O[Li]>C1(=CC(=CC(=N1)C)NC2=NC=3N(C(=C2)N(CC4=CC=CC=C4)CC5=CC=CC=C5)N=CC3C(O)=O)N6C[C@H](CCC6)O>CN(C)C(=[N+](C)C)ON1C2=C(C=CC=N2)N=N1.F[P-](F)(F)(F)(F)F.[NH4+].[Cl-].CN(C)C=O.CCN(C(C)C)C(C)C>C1(=CC(=CC(=N1)C)NC2=NC=3N(C(=C2)N(CC4=CC=CC=C4)CC5=CC=CC=C5)N=CC3C(N)=O)N6C[C@H](CCC6)O>>C1(=CC(=CC(=N1)C)NC2=NC=3N(C(=C2)N)N=CC3C(N)=O)N4C[C@H](CCC4)O |f:4.5.6.7.8,16.17,18.19|  US20190241576A1"
  # 
  # rxn_set <- smiles_parser$parseReactionSetSmiles(multi_smiles)
  # .jclass(rxn_set)
  # svg  <- depiction() |> depict(rxn_set)
  # 
  # expect_equal(svg, 'svg')

})
