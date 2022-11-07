#'
#' rCDK Version of the CDK Depict App.
#'
#' Main Java Class here: https://github.com/cdk/depict/blob/master/cdkdepict-lib/src/main/java/org/openscience/cdk/app/DepictController.java
#' 
#' see https://www.simolecule.com/cdkdepict/depict.html

library(shiny)
library(depict)


# Java Helper Classes -----------------------------------

color       <- J("java.awt.Color")
unicolor    <- J("org.openscience.cdk.renderer.color.UniColor")
cdk2dcolors <- J("org.openscience.cdk.renderer.color.CDK2DAtomColors")



# Data  --------------

# see https://www.simolecule.com/cdkdepict/depict.html
initial_smiles <- "CN1C=NC2=C1C(=O)N(C(=O)N2C)C caffeine
[Cs+].[O-]C(=O)[O-].[Cs+] Cs2CO3
[Li+].[Al+3].[H-].[H-].[H-].[H-] LiAlH4
Cl[Pt@SP1](Cl)([NH3])[NH3] cis-platin
O=[N+]([O-])[Co@]([NH3])([NH3])([NH3])([NH3])[N+]([O-])(=O) trans-[Co(NH3)4(NO2)2]
Cl*.Cl*.c1ccccc1-c1ccccc1 |m:1:4.5.6.7.8.9,3:10.11.12.13.14.15| dichlorobiphenyl
CCOCCOCCO |Sg:n:3,4,5::ht| PEGn
*c1ccccc1 |$_AP1$| phenyl
CC(C)[C@H](N*)C(*)=O |$;;;;;_AP1;;_AP2;$| valine monomer
c1(:*:c2c(:*:c1*)C(N(N2)*)=O)* |$;Y;;;X;;R10;;;;Z;;R11$| US 2007/0129374 (I)
C*.C*.C1=CC=CC=C1C=2C(C=CN3C2C=*C(=*3)C**)=O.C* |$;R2;;R3;;;;;;;;;;;;;;W;;A;;X;R4;;;R1$,m:0:5.4.9.8.7.6,2:7.6.5.4.9.8,24:4.9.8.7.6.5,Sg:n:20:m:ht| US 2007/0129372 (I)
[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].[Na+].CCCCc1ccc(CO[C@H]2O[C@H](COS(=O)(=O)[O-])[C@@H](OS(=O)(=O)[O-])[C@H](OS(=O)(=O)[O-])[C@@H]2O[C@H]3O[C@H](COS(=O)(=O)[O-])[C@@H](OS(=O)(=O)[O-])[C@H](O[C@H]4O[C@H](COS(=O)(=O)[O-])[C@@H](OS(=O)(=O)[O-])[C@H](O[C@H]5O[C@H](COS(=O)(=O)[O-])[C@@H](OS(=O)(=O)[O-])[C@H](OS(=O)(=O)[O-])[C@@H]5OS(=O)(=O)[O-])[C@@H]4OS(=O)(=O)[O-])[C@@H]3OS(=O)(=O)[O-])cc1 CHEMBL590010
"

# Todo: Problems here
# CCO.[CH3:1][C:2](=[O:3])[OH:4]>[H+]>CC[O:4][C:2](=[O:3])[CH3:1].O Ethyl esterification [1.7.3]
# [CH3:9][CH:8]([CH3:10])[c:7]1[cH:11][cH:12][cH:13][cH:14][cH:15]1.[CH2:3]([CH2:4][C:5](=[O:6])Cl)[CH2:2][Cl:1]>[Al+3].[Cl-].[Cl-].[Cl-].C(Cl)Cl>[CH3:9][CH:8]([CH3:10])[c:7]1[cH:11][cH:12][c:13]([cH:14][cH:15]1)[C:5](=[O:6])[CH2:4][CH2:3][CH2:2][Cl:1] |f:2.3.4.5| Friedel-Crafts acylation [3.10.1]



mol_color_options <- list(
  "Black on Clear",
  "Black on White", 
  #"Color on Black",
  "Color on Clear",
  "Color on White", 
  # "Neon on Black",
  "White on Black")



# Functions ------------------------


#' apply_color_scheme
#'
#' handle colors
#' See https://github.com/cdk/depict/blob/master/cdkdepict-lib/src/main/java/org/openscience/cdk/app/DepictController.java#L978
#' 
apply_color_scheme <- function(depgen, mol_color_opt) {
  
  black      <- color$BLACK
  black_uni  <- new(unicolor, color$BLACK)
  white      <- color$WHITE
  white_uni  <- new(unicolor, color$WHITE)
  transparent <- .jnew("java/awt/Color", 0L, 0L, 0L, 0L)
  colors_2d  <- new(cdk2dcolors)
  
  # Todo: to get the color on black or the neon on black you need to
  # override the base CDK 2DAtomsColors
  # https://github.com/cdk/depict/blob/master/cdkdepict-lib/src/main/java/org/openscience/cdk/app/DepictController.java#L978-L1069
  
  switch(
    mol_color_opt,
    "Black on White" =  (depgen |>  color_atoms(black_uni) |> color_background(white)),
    "Black on Clear" =  (depgen |>  color_atoms(black_uni) |> color_background(transparent)),
    # "Color on Black" =  (depgen |>  color_atoms(colors_2d) |> color_background(black)),
    "Color on Clear" =  (depgen |>  color_atoms(colors_2d) |> color_background(transparent) |> outerglow()),
    "Color on White" =  (depgen |>  color_atoms(colors_2d) |> color_background(white) |> outerglow()),
    # "Neon on Black")
    "White on Black" =  (depgen |>  color_atoms(white_uni) |> color_background(black)),
    
    
    
    { 
      warning(sprintf("this option (%s) is implemented", mol_color_opt))
      depgen
    }
  )
}



# UI  --------------

ui <- fluidPage(
  titlePanel("rCDK depict. Generate depictions of molecules and reactions from SMILES."),
  textAreaInput(
    "smiles",
    label ="SmilesData",
    value = initial_smiles,
    width="100%"),
  flowLayout(
    selectInput("colors", "Colors", mol_color_options, selected = "Black on White"),
  
    # selectInput("annotations",
    #             "Annotations",
    #             list("No Annotation", 
    #                  "Atom Numbers", 
    #                  "Atom Mapping", 
    #                  "Color Map",
    #                  "Atom Value",
    #                  "CIP Stereo Label")),
    # selectInput("hydrogens",
    #             "Hydrogens",
    #             list("Chiral Hydrogens",
    #                  "Minimal Hydrogens",
    #                  "Chiral Hydrogens (smart)",
    #                  "Default Hydrogens")),
    # selectInput("abbreviations_and_groups",
    #             "Abbreviations and Groups",
    #             list("Abbreviate Reagents and Groups",
    #                  "Abbreviate Reagetns",
    #                  "Abbreviate Groups",
    #                  "Do Not Abbreviate")),
  
    textInput("smarts_pattern","SMARTS Pattern:", placeholder = "enter SMARTS pattern here....")
    ),
  imageOutput("smilesimage")
)





# Server  --------------

server <- function(input, output, session) {

  output$smilesimage <- renderImage({
    dataset         <- input$smiles
    color_option    <- input$colors
    # Todo: more robust SMILES parsing.....
    smiles_strings  <- strsplit(dataset, "\n")[[1]]
    # print(smiles_strings)
    atmcontainers   <- purrr::map(smiles_strings, parse_smiles)
    many_containers <- atomcontainer_list_to_jarray(atmcontainers)
    

    tmpf <- tempfile(fileext='.png')
    
    dep <- depiction()
    
    dep <- dep |> apply_color_scheme(color_option)
    
    dep |> 
      depict(many_containers) |>
      save_image(tmpf)
    
    # return a list
    list(src = tmpf, alt = "Images of Compounds")
  },
  
  deleteFile = TRUE)
}



# Launch  --------------

shinyApp(ui, server)
