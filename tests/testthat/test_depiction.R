library("testthat")
library("depict")
library("magrittr")
library("grid")


context("Test Depiction")

test_that("we can depict a molecule", {
  
  # load in penicillin
  pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
  cav  <- parse_smiles("CN1C=NC2=C1C(=O)N(C(=O)N2C)C")
  
  atomcontainerclasses  <- c("org/openscience/cdk/AtomContainer2",
                             "org/openscience/cdk/AtomContainer",
                             "org/openscience/cdk/silent/AtomContainer2",
                             "org/openscience/cdk/silent/AtomContainer",
                             "org/openscience/cdk/IAtomContainer")
  
  expect_true(attr(pen, "jclass") %in% atomcontainerclasses)
  expect_true(attr(cav, "jclass") %in% atomcontainerclasses)
  
  dep <- depiction() %>%  depict(pen)
  expect_equal(attr(dep, "jclass"), "org/openscience/cdk/depict/MolGridDepiction")
  
  img <- get_image(dep)
  expect_true(inherits(img, 'array'))
  
})