rm(list=ls())
library(spatstat)
library(R.matlab)
library(cramer)
library(ks)
#---------------------------------------------------------------
# P(xD)
# load Summer source point cluster
source("D:/workspace/TempWork/NewData/InfoExtract/P(xD)/Summer.R")
# Take the normed NND
Summer_NormNND<-norm_NND
# load subSummer source point cluster
source("D:/workspace/TempWork/NewData/InfoExtract/P(xD)/subSummer.R")
# Take the normed NND
subSummer_NormNND<-norm_NND
# load Borneo source point cluster
source("D:/workspace/TempWork/NewData/InfoExtract/P(xD)/Borneo.R")
# Take the normed NND
Borneo_NormNND<-norm_NND
# load WCD source point cluster
source("D:/workspace/TempWork/NewData/InfoExtract/P(xD)/WCD.R")
# Take the normed NND
WCD_NormNND<-norm_NND
# load subWCD source point cluster
source("D:/workspace/TempWork/NewData/InfoExtract/P(xD)/subWCD.R")
# Take the normed NND
subWCD_NormNND<-norm_NND

#---------------------------------------------------------------
# compare summer to borneo
CT_SB = cramer.test(Summer_NormNND,Borneo_NormNND)

# compare WCD to borneo
CT_WB = cramer.test(WCD_NormNND,Borneo_NormNND)

# compare WCD to Summer
CT_WS = cramer.test(WCD_NormNND,Summer_NormNND)

#---------------------------------------------------------------
# compare subSummer to summer
CT_SubSS = cramer.test(subSummer_NormNND,Summer_NormNND)

# compare subSummer to WCD
CT_SubSW = cramer.test(subSummer_NormNND,WCD_NormNND)

# compare subSummer to borneo
CT_SubSB = cramer.test(subSummer_NormNND,Borneo_NormNND)

# compare subSummer to subWCD
CT_SubSSubW = cramer.test(subSummer_NormNND,subWCD_NormNND)

#---------------------------------------------------------------
# compare subWCD to summer
CT_SubWS = cramer.test(subWCD_NormNND,Summer_NormNND)

# compare subWCD to WCD
CT_SubWW = cramer.test(subWCD_NormNND,WCD_NormNND)

# compare subWCD to borneo
CT_SubWB = cramer.test(subWCD_NormNND,Borneo_NormNND)

#---------------------------------------------------------------
# output string
CompList = c('SB','WB','WS','SubSS','SubSW','SubSB','SSSW','SubWS','SubWW','SubWB')
#pvals = c(0,0,0,0,0, 0,0,0,0,0);
SB<-CT_SB$p.val
WB<-CT_WB$p.val
WS<-CT_WS$p.val
SubSS<-CT_SubSS$p.val
SubSW<-CT_SubSW$p.val
SubSB<-CT_SubSB$p.val
SubSSubW<-CT_SubSSubW$p.val
SubWS<-CT_SubWS$p.val
SubWW<-CT_SubWW$p.val
SubWB<-CT_SubWB$p.val
# writeMat("D:/workspace/TempWork/ChanLobeModel/LinkingScales/bdmap.mat",bdmap=bdmap)
# writeMat("D:/workspace/TempWork/ChanLobeModel/LinkingScales/tdmap.mat",tdmap=tdmap)
