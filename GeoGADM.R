library(sp)
library(maptools)
library(rgeos)


# Fetch sptaial geo data --------------------------------------------------


# Prepare geo data
load("your_path/NLD_adm3.RData")
gadm_new <- gadm
# Remove water bodies
gadm_new <- gadm_new[!gadm_new$NAME_1 %in% c("Zeeuwse meren","IJsselmeer"),]
# gadm_new <- gadm_new[gadm_new$NAME_1!="Zeeuwse meren"& gadm_new$NAME_1!="IJsselmeer",]  # alternativesave
# test.data <- gadm_new@data[,c("ID_2","NAME_2","NAME_1")]
# test1.data <- test.data[order(test.data$NAME_2),]


# Rename municipalities ---------------------------------------------------


gadm_new$NAME_2[gadm_new$NAME_2 %in% c("'s-Gravenhage")]<-"Den Haag"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Haarlemmerliede c.a.")]<-"Haarlemmerliede en Spaarnwoude"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Kollumerland c.a.")]<-"Kollumerland en Nieuwkruisland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bergh")]<-"Montferland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Kesteren")]<-"Neder-Betuwe"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Nuenen c.a.")]<-"Nuenen, Gerwen en Nederwetten"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Rijssen")]<-"Rijssen-Holten"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Dantumadeel")]<-"Dantumadiel"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Menaldumadeel")]<-"Menameradiel"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("'s-Gravenhage")]<-"Den Haag"
gadm_new$NAME_2[gadm_new$ID_2 %in% (80)]<-"Hengelo GLD" # To distinguish from 'Hengelo Overijssel' with ID 338
gadm_new$NAME_2[gadm_new$ID_2 %in% (271)]<-"Bergen (NH.)" # To distinguish from 'Bergen (L)' with ID 151
gadm_new$NAME_2[gadm_new$ID_2 %in% (151)]<-"Bergen (L.)" # To distinguish from 'Bergen (NH)' with ID 271

test.data <- gadm_new@data[,c("ID_2","NAME_2","NAME_1")]
test2.data <- test.data[order(test.data$NAME_2),]


# Merge municipalities to situation as of 1-1-2015 ------------------------


# Change ID's
gadm_new$ID_2[gadm_new$ID_2 %in% c(50,62)]<-"50" 
gadm_new$ID_2[gadm_new$ID_2 %in% c(264,282,308)]<-"264"
gadm_new$ID_2[gadm_new$ID_2 %in% c(407,416,465)]<-"407" 
gadm_new$ID_2[gadm_new$ID_2 %in% c(57,68,90,102)]<-"57"
gadm_new$ID_2[gadm_new$ID_2 %in% c(401,413)]<-"401"
gadm_new$ID_2[gadm_new$ID_2 %in% c(270,274)]<-"270"
gadm_new$ID_2[gadm_new$ID_2 %in% c(415,462)]<-"415"
gadm_new$ID_2[gadm_new$ID_2 %in% c(82,104,108,118,80)]<-"82"
gadm_new$ID_2[gadm_new$ID_2 %in% c(27,34,41)]<-"41"
gadm_new$ID_2[gadm_new$ID_2 %in% c(354,362)]<-"354"
gadm_new$ID_2[gadm_new$ID_2 %in% c(329,332)]<-"329"
gadm_new$ID_2[gadm_new$ID_2 %in% c(64,111)]<-"64"
gadm_new$ID_2[gadm_new$ID_2 %in% c(279,314)]<-"279"
gadm_new$ID_2[gadm_new$ID_2 %in% c(154,170)]<-"154"
gadm_new$ID_2[gadm_new$ID_2 %in% c(217,233)]<-"217"
gadm_new$ID_2[gadm_new$ID_2 %in% c(422,425,446,457)]<-"422"
gadm_new$ID_2[gadm_new$ID_2 %in% c(268,300,319,320)]<-"268"
gadm_new$ID_2[gadm_new$ID_2 %in% c(162,171,182)]<-"162"
gadm_new$ID_2[gadm_new$ID_2 %in% c(406,433)]<-"406"
gadm_new$ID_2[gadm_new$ID_2 %in% c(434,464,477)]<-"434"
gadm_new$ID_2[gadm_new$ID_2 %in% c(302,318)]<-"302"
gadm_new$ID_2[gadm_new$ID_2 %in% c(410,411,414)]<-"410"
gadm_new$ID_2[gadm_new$ID_2 %in% c(21,32)]<-"21"
gadm_new$ID_2[gadm_new$ID_2 %in% c(157,161,163,180)]<-"157"
gadm_new$ID_2[gadm_new$ID_2 %in% c(74,87)]<-"74"
gadm_new$ID_2[gadm_new$ID_2 %in% c(158,167,187)]<-"158"
gadm_new$ID_2[gadm_new$ID_2 %in% c(267,297,301,317,322)]<-"267"
gadm_new$ID_2[gadm_new$ID_2 %in% c(444,471)]<-"444"
gadm_new$ID_2[gadm_new$ID_2 %in% c(428,442,451)]<-"428"
gadm_new$ID_2[gadm_new$ID_2 %in% c(441,453,476)]<-"441"
gadm_new$ID_2[gadm_new$ID_2 %in% c(136,137,143)]<-"136"
gadm_new$ID_2[gadm_new$ID_2 %in% c(75,84)]<-"75"
gadm_new$ID_2[gadm_new$ID_2 %in% c(230,232,240)]<-"230"
gadm_new$ID_2[gadm_new$ID_2 %in% c(73,116)]<-"73"
gadm_new$ID_2[gadm_new$ID_2 %in% c(160,165,168,173)]<-"160"
gadm_new$ID_2[gadm_new$ID_2 %in% c(147,178)]<-"147"
gadm_new$ID_2[gadm_new$ID_2 %in% c(179,186)]<-"179"
gadm_new$ID_2[gadm_new$ID_2 %in% c(467,468)]<-"467"
gadm_new$ID_2[gadm_new$ID_2 %in% c(286,307,327)]<-"286"
gadm_new$ID_2[gadm_new$ID_2 %in% c(358,370,373)]<-"358"
gadm_new$ID_2[gadm_new$ID_2 %in% c(22,37,43,48,49)]<-"49"
gadm_new$ID_2[gadm_new$ID_2 %in% c(469,480,483)]<-"469"
gadm_new$ID_2[gadm_new$ID_2 %in% c(355,363,364,368,372)]<-"355"
gadm_new$ID_2[gadm_new$ID_2 %in% c(148,190)]<-"148"
gadm_new$ID_2[gadm_new$ID_2 %in% c(403,420,447,449,485)]<-"403"
gadm_new$ID_2[gadm_new$ID_2 %in% c(51,61,119)]<-"51"
gadm_new$ID_2[gadm_new$ID_2 %in% c(448,452,488)]<-"448"
gadm_new$ID_2[gadm_new$ID_2 %in% c(110,120)]<-"110"

# Change Names
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Aalten","Dinxperlo")]<-"Aalten"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Alkmaar","Graft-De Rijp","Schermer")]<-"Alkmaar"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Alphen aan den Rijn","Boskoop","Rijnwoude")]<-"Alphen aan den Rijn"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Borculo","Eibergen","Neede","Ruurlo")]<-"Berkelland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("'s-Gravendeel","Binnenmaas")]<-"Binnenmaas"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bennebroek","Bloemendaal")]<-"Bloemendaal"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bodegraven","Reeuwijk")]<-"Bodegraven-Reeuwijk"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Hummelo en Keppel","Steenderen","Vorden","Zelhem","Hengelo GLD")]<-"Bronckhorst"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Gaasterlân-Sleat","Lemsterland","Skarsterlân")]<-"De Friese Meren"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Abcoude","De Ronde Venen")]<-"De Ronde Venen"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bathmen","Deventer")]<-"Deventer"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Doetinchem","Wehl")]<-"Doetinchem"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Drechterland","Venhuizen")]<-"Drechterland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Eijsden","Margraten")]<-"Eijsden-Margraten"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Geldrop","Mierlo")]<-"Geldrop-Mierlo"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Dirksland","Goedereede","Middelharnis","Oostflakkee")]<-"Goeree-Overflakkee"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Anna Paulowna","Niedorp","Wieringen","Wieringermeer")]<-"Hollands Kroon"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Horst aan de Maas","Meerlo-Wanssum","Sevenum")]<-"Horst aan de Maas"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Alkemade","Jacobswoude")]<-"Kaag en Braassem"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Katwijk","Rijnsburg","Valkenburg")]<-"Katwijk"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Obdam","Wester-Koggenland")]<-"Koggenland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bergschenhoek","Berkel en Rodenrijs","Bleiswijk")]<-"Lansingerland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Boarnsterhim","Leeuwarden")]<-"Leeuwarden"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Haelen","Heythuysen","Hunsel","Roggel en Neer")]<-"Leudal"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Gorssel","Lochem")]<-"Lochem"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Heel","Maasbracht","Thorn")]<-"Maasgouw"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Andijk","Medemblik","Noorder-Koggenland","Wervershoof","Wognum")]<-"Medemblik"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Maasland","Schipluiden")]<-"Midden-Delfland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Graafstroom","Liesveld","Nieuw-Lekkerland")]<-"Molenwaard"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Liemeer","Nieuwkoop","Ter Aar")]<-"Nieuwkoop"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Reiderland","Scheemda","Winschoten")]<-"Oldambt"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Groenlo","Lichtenvoorde")]<-"Oost Gelre"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Lith","Maasdonk","Oss")]<-"Oss"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Gendringen","Wisch")]<-"Oude IJsselstreek"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Helden","Kessel","Maasbree","Meijel")]<-"Peel en Maas"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Ambt Montfort","Roerdalen")]<-"Roerdalen"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Roermond","Swalmen")]<-"Roermond"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Rotterdam","Rozenburg")]<-"Rotterdam"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Harenkarspel","Schagen","Zijpe")]<-"Schagen"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Breukelen","Loenen","Maarssen")]<-"Stichtse Vecht"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Bolsward","Sneek","Wûnseradiel","Wymbritseradiel","Nijefurd")]<-"SudWest-Fryslan"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Sassenheim","Voorhout","Warmond")]<-"Teylingen"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Amerongen","Doorn","Driebergen-Rijsenburg","Leersum","Maarn")]<-"Utrechtse Heuvelrug"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Arcen en Velden","Venlo")]<-"Venlo"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("'s-Gravenzande","De Lier","Monster","Naaldwijk","Wateringen")]<-"Westland"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Angerlo","Didam","Zevenaar")]<-"Zevenaar"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Moordrecht","Nieuwerkerk aan den IJssel","Zevenhuizen-Moerkapelle")]<-"Zuidplas"
gadm_new$NAME_2[gadm_new$NAME_2 %in% c("Warnsveld","Zutphen")]<-"Zutphen"

test.data <- gadm_new@data[,c("ID_2","NAME_2","NAME_1")]
test3.data <- test.data[order(test.data$NAME_2),]
# merge polygons
gadm_new.sp <- unionSpatialPolygons(gadm_new, gadm_new$ID_2)
# merge data
gadm_new@data$ID_2 <- as.integer(gadm_new@data$ID_2)
gadm_new.data <- unique(gadm_new@data[,c("ID_2","NAME_2","NAME_1")])
# rownames of the associated data frame must be the same as polygons IDs
rownames(gadm_new.data) <- gadm_new.data$ID_2
# build the new SpatialPolygonsDataFrame
gadm_new <- SpatialPolygonsDataFrame(gadm_new.sp, gadm_new.data) 


# Export files ------------------------------------------------------------


# save reshaped gadm file
save(gadm_new, file="your_path/gadm_new.RDATA")
test.data <- gadm_new@data[,c("ID_2","NAME_2","NAME_1")]
Municipalities <- test.data[order(test.data$NAME_2),]
save(Municipalities, file="your_path/Municipalities.RData")


# Remove obsolete files ---------------------------------------------------

# remove obsolete objects
rm(list=ls())

