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



test_that("coloring works", {
  
  # load in penicillin
  #pen  <- parse_smiles("CCCCC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
  pen  <- parse_smiles("CCCCC")
  
  # test basic coloring
  dep <- depiction() |> color_atoms() |> depict(pen)
  expect_equal(attr(dep, "jclass"), "org/openscience/cdk/depict/MolGridDepiction")
  
  # test advanced coloring
  colors <- J("org.openscience.cdk.renderer.color.CDK2DAtomColors")
  colorer <- new(colors)
  dep <- depiction() |> color_atoms(colorer) |> depict(pen)
  expect_equal(attr(dep, "jclass"), "org/openscience/cdk/depict/MolGridDepiction")
  
  # test background coloring
  colors <- J("java.awt.Color")
  dep <- depiction() |> color_background(colors$BLACK) |> depict(pen)
  expect_equal(attr(dep, "jclass"), "org/openscience/cdk/depict/MolGridDepiction")
  
})