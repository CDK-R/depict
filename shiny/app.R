#'
#' rCDK Version of the CDK Depict App.
#'
#' Main Java Class here: https://github.com/cdk/depict/blob/master/cdkdepict-lib/src/main/java/org/openscience/cdk/app/DepictController.java
#' 
#' see https://www.simolecule.com/cdkdepict/depict.html

library(shiny)
library(depict)


# Initial Data  --------------

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


# UI  --------------

ui <- fluidPage(
  titlePanel("rCDK depict. Generate depictions of molecules and reactions from SMILES."),
  textAreaInput(
    "smiles",
    label ="SmilesData",
    value = initial_smiles,
    width="100%"),
  flowLayout(
    selectInput("colors",
                "Colors", 
                list("Color on White", 
                     "Color on Black",
                     "Color on Clear",
                     "Black on White", 
                     "Black on Clear",
                     "White on Black",
                     "Neon on Black")),
    selectInput("annotations",
                "Annotations",
                list("No Annotation", 
                     "Atom Numbers", 
                     "Atom Mapping", 
                     "Color Map",
                     "Atom Value",
                     "CIP Stereo Label")),
    selectInput("hydrogens",
                "Hydrogens",
                list("Chiral Hydrogens",
                     "Minimal Hydrogens",
                     "Chiral Hydrogens (smart)",
                     "Default Hydrogens")),
    selectInput("abbreviations_and_groups",
                "Abbreviations and Groups",
                list("Abbreviate Reagents and Groups",
                     "Abbreviate Reagetns",
                     "Abbreviate Groups",
                     "Do Not Abbreviate")),
  
    textInput("smarts_pattern","SMARTS Pattern:", placeholder = "enter SMARTS pattern here....")
    ),
  imageOutput("smilesimage")
)





# Server  --------------

server <- function(input, output, session) {

  output$smilesimage <- renderImage({
    dataset         <- input$smiles
    
    # Todo: more robust SMILES parsing.....
    smiles_strings  <- strsplit(dataset, "\n")[[1]]
    # print(smiles_strings)
    atmcontainers   <- purrr::map(smiles_strings, parse_smiles)
    many_containers <- atomcontainer_list_to_jarray(atmcontainers)
    

    tmpf <- tempfile(fileext='.png')
    
    depiction() |>
      depict(many_containers) |>
      save_image(tmpf)
    
    # return a list
    list(src = tmpf, alt = "Images of Compounds")
  },
  
  deleteFile = TRUE)
}



# Launch  --------------

shinyApp(ui, server)
