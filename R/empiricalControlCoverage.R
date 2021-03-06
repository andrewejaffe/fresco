#' Visualization of empirical control coverage across technical covariates
#' 
#' @param object \code{MethylSet} object
#' @param sdThreshold Standard deviation cut-off for filtering empirical controls
#' 
#' @export empiricalControlCoverage


empiricalControlCoverage <- function(object, sdThreshold = .1){

  if (!is(object, "MethylSet")) stop("'object' needs to be a 'MethylSet'")
  
  data(frescoData)
  
  # create object for methylated and unmethylated channels ------------------
  methTmp <- getMeth(object)
  probeIDs <- rownames(methTmp)
  signals <- array(dim = c(dim(methTmp), 2))
  signals[, , 1] <- getUnmeth(object)
  signals[, , 2] <- methTmp
  frescoData <- frescoData[match(probeIDs, rownames(frescoData)), ]
  GC <- frescoData$targetGC
  
  log2Centered <- apply(log2(signals + 1), c(1, 3), mean, trim = .1)
  
  # filter controls and create indicator variables --------------------------
  probeSD <- apply(getBeta(object), 1, sd)
  frescoData$eControls[probeSD > sdThreshold] <- NA
  typeI <- which(frescoData$probeType == 'I')
  typeII <- which(frescoData$probeType == 'II')
  hemEC <- which(frescoData$eControls == 'Hemimethylated')
  methEC <- which(frescoData$eControls == 'Methylated')
  umethEC <- which(frescoData$eControls == 'Unmethylated')
  
  par(mfrow = c(2, 3))
  controlCex <- .7
  
  # type I probes M & UM
  smoothScatter(log2Centered[typeI, 2:1], xlab = 'log2(Methylated Signal)',
                ylab = 'log2(Unmethylated Signal)')
  
  points(log2Centered[intersect(methEC, typeI), 2:1], 
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC, typeI), 2:1], 
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC, typeI), 2:1], 
         pch = 16, cex = controlCex, col = 'yellow')
  
  # type I probes M & GC
  smoothScatter(log2Centered[typeI, 2], GC[typeI],
                xlab = 'log2(Methylated Signal)',
                ylab = 'Target GC Content',
                main = 'Type I Probes')
  
  points(log2Centered[intersect(methEC,typeI), 2],
         GC[intersect(methEC, typeI)],
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC,typeI), 2], 
         GC[intersect(umethEC, typeI)],
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC,typeI), 2], 
         GC[intersect(hemEC, typeI)],
         pch = 16, cex = controlCex, col = 'yellow')
  
  # type I UM & GC
  smoothScatter(log2Centered[typeI, 1], GC[typeI],
                xlab = 'log2(Unmethylated Signal)',
                ylab = 'Target GC Content')
  
  points(log2Centered[intersect(methEC, typeI), 1], 
         GC[intersect(methEC, typeI)],
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC, typeI), 1], 
         GC[intersect(umethEC, typeI)],
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC, typeI), 1], 
         GC[intersect(hemEC, typeI)],
         pch = 16, cex = controlCex, col = 'yellow')
  
  # type II probes M & UM
  smoothScatter(log2Centered[typeII, 2:1], xlab = 'log2(Methylated Signal)',
                ylab = 'log2(Unmethylated Signal)')
  
  points(log2Centered[intersect(methEC,typeII), 2:1], 
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC, typeII), 2:1], 
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC, typeII), 2:1], 
         pch = 16, cex = controlCex, col = 'yellow')
  
  # type II M & GC
  smoothScatter(log2Centered[typeII, 2], GC[typeII],
                xlab = 'log2(Methylated Signal)',
                ylab = 'Target GC Content',
                main = 'Type II Probes')
  
  points(log2Centered[intersect(methEC, typeII), 2], 
         GC[intersect(methEC, typeII)],
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC, typeII), 2], 
         GC[intersect(umethEC, typeII)],
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC, typeII), 2], 
         GC[intersect(hemEC, typeII)],
         pch = 16, cex = controlCex, col = 'yellow')
  
  # type II UM & GC
  smoothScatter(log2Centered[typeII, 1], GC[typeII],
                xlab = 'log2(Unmethylated Signal)', 
                ylab = 'Target GC Content')
  
  points(log2Centered[intersect(methEC, typeII), 1], 
         GC[intersect(methEC, typeII)],
         pch = 16, cex = controlCex, col = 'red')
  
  points(log2Centered[intersect(umethEC, typeII), 1], 
         GC[intersect(umethEC, typeII)],
         pch = 16, cex = controlCex, col = 'green')
  
  points(log2Centered[intersect(hemEC, typeII), 1], 
         GC[intersect(hemEC, typeII)],
         pch = 16, cex = controlCex, col = 'yellow')
  
}
  
  
  
  
  
  
  
  
  
