library("testthat")
library("depict")

context("Test IO")

test_that("we can open MOL file", {
  molfile <- system.file("molfiles/ChEBI_5931.mol", package = "depict")
  sdffile <- system.file("molfiles/Structure2D_CID_14969.sdf", package = "depict")

  mol <- read_mol(molfile)
  sdf <- read_mol(sdffile)

  expect_equal(attr(mol, "jclass"), "org/openscience/cdk/AtomContainer")
  expect_equal(attr(sdf, "jclass"), "org/openscience/cdk/AtomContainer")
})


test_that("we can parse a reaction smiles", {
  sp <- J("org.openscience.cdk.smiles.SmilesParser")
  silentchemobject <- J("org.openscience.cdk.silent.SilentChemObjectBuilder")
  smiles_parser <- new(sp, silentchemobject$getInstance())

  rxn <- smiles_parser$parseReactionSmiles("[CH3:9][CH:8]([CH3:10])[c:7]1[cH:11][cH:12][cH:13][cH:14][cH:15]1.[CH2:3]([CH2:4][C:5](=[O:6])Cl)[CH2:2][Cl:1]>[Al+3].[Cl-].[Cl-].[Cl-].C(Cl)Cl>[CH3:9][CH:8]([CH3:10])[c:7]1[cH:11][cH:12][c:13]([cH:14][cH:15]1)[C:5](=[O:6])[CH2:4][CH2:3][CH2:2][Cl:1] |f:2.3.4.5| Friedel-Crafts acylation [3.10.1]")
  expect_equal(attr(rxn, "jclass"), "org/openscience/cdk/silent/Reaction")
})
