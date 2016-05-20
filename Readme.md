---
title: "Readme.RMD"
author: "zachcp"
date: "May 19, 2016"
output: html_document
---



## CDK Depict 

A simple wrapper around rcdk's excellent depict module.


```r
library(webchem)
library(rcdk)
library(cdkdepict)
```

## Basic Depiction 

You can also embed plots, for example:


```r
# get a few smiles by name
cafsmiles  <- webchem::cir_query(c("caffeine","penicillin"), representation = "smiles")

# parse the smiles into CDK AtomContainers
caffeine   <- parse.smiles(cafsmiles$caffeine)[[1]]
penicillin <- parse.smiles(cafsmiles$penicillin)[[1]]

# depict
depict(caffeine,molfile = "images/caffeine.png")
depict(penicillin,molfile = "images/penicillin.png")
```

![](images/caffeine.png)
![](images/penicillin.png)


### Change the Zoom Level


```r
depict(caffeine,  zoom=2, molfile = "images/caffeine_zoom.png")
depict(penicillin,zoom=2, molfile = "images/penicillin_zoom.png")
```
![](images/caffeine_zoom.png)
![](images/penicillin_zoom.png)


### Remove the Color


```r
depict(caffeine,  atomcolors = FALSE, molfile = "images/caffeine_BW.png")
depict(penicillin,atomcolors = FALSE, molfile = "images/penicillin_BW.png")
```

![](images/caffeine_BW.png)
![](images/penicillin_BW.png)

