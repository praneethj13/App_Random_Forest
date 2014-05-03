# Graphical Plots for Random Forest Analysis------------------------------------------------------

classAccuracyPlot <- function(accuracy, confusion_table, celltextsize, fontsize){
  
  fontsize <- as.numeric(fontsize)
  
  g1 <- ggplot(data=accuracy,aes(x=Segment, y=Accuracy, group=Segment, colour=Segment, fill=Segment)) +
    theme_grey(base_size=fontsize) + 
    theme(legend.position="top", legend.key.width=unit(0.1/nlevels(accuracy$Segment),"npc")) +
    scale_fill_manual(values=c(clrs[1:(nlevels(accuracy$Segment))])) + 
    scale_colour_manual(values=c(clrs[1:(nlevels(accuracy$Segment))])) +
    geom_bar(stat="identity") +
    geom_text(aes(label=paste0(Accuracy, "%")), colour="white", vjust=2, size=fontsize/2) +
    scale_y_continuous()
  
  g2 <- ggplot(data=confusion_table, aes(x = X, y = Y, fill = Count, label=Count)) + 
    theme_grey(base_size=fontsize) + theme(legend.position="top", legend.key.width=unit(0.1,"npc")) +
    labs(x = "Predicted Segments and Segment Accuracy", y = "Original Segment") +
    geom_raster() +
    scale_fill_gradient( low = "white", high = "dodgerblue", na.value="black", name = "Correct Classification(Count)" ) +
    geom_text(size=celltextsize) +
    geom_rect(size=0.5, fill=NA, colour="black",
              aes(xmin=length(levels(X))-0.5, xmax=length(levels(X))+0.5, ymin=1-0.5, ymax=length(levels(Y))+0.5)) +
    geom_rect(size=0.5, fill=NA, colour="black",
              aes(xmin=1-0.5, xmax=length(levels(X))+0.5, ymin=1-0.5, ymax=length(levels(Y))+0.5)) +
    scale_x_discrete(expand = c(0, 0)) +
    scale_y_discrete(expand = c(0, 0))
  
  gA <- ggplot_gtable(ggplot_build(g1))
  gB <- ggplot_gtable(ggplot_build(g2))
  gA$widths <- gB$widths
  grid.arrange(gA,gB,ncol=1)
}

importancePlot <- function(d, ylb, fontsize){
  fontsize <- as.numeric(fontsize)
  d <- d[order(d[,ylb]),]
  d$Predictor <- factor(as.character(d$Predictor),levels=rev(as.character(d$Predictor)))
  rownames(d) <- NULL
  abs.min <- abs(min(d[,2]))
  g1 <- ggplot(data=d,aes_string(x="Predictor",y=ylb,group="Predictor",colour="Predictor",fill="Predictor")) + geom_bar(stat="identity") + theme_grey(base_size=fontsize)
  if(ylb=="mda") g1 <- g1 + labs(y="Mean decrease in accuracy") else if(ylb=="mdg") g1 <- g1 + labs(y="Mean decrease in Gini")
  g1 <- g1 + theme(axis.text.x = element_text(angle=90,hjust=1,vjust=0.4)) + geom_hline(yintercept=abs.min,linetype="dashed",colour="black")
  print(g1)
}

importanceTable <- function(d,lab, celltextsize, fontsize){
  d <- melt(d)
  names(d) <- c("Y","X","Importance")
  
  fontsize <- as.numeric(fontsize)
  g1 <- ggplot(data=d, aes(x = X, y = Y, fill = Importance, label=Importance)) + 
    theme_grey(base_size=fontsize) + 
    theme(legend.position="top", legend.key.width=unit(0.1,"npc")) +
    labs(x = "Response class and mean performance measures", y = "Predictor") +
    geom_raster() +
    geom_text(size=celltextsize) +
    scale_fill_gradient( low = "white", high = "dodgerblue", na.value="black", name = "Importance" ) +
    geom_rect(size=1, fill=NA, colour="black",
              aes(xmin=length(levels(X))-1-0.5, xmax=length(levels(X))-1+0.5, ymin=1-0.5, ymax=length(levels(Y))+0.5)) +
    geom_rect(size=2, fill=NA, colour="black",
              aes(xmin=1-0.5, xmax=length(levels(X))+0.5, ymin=1-0.5, ymax=length(levels(Y))+0.5)) +
    scale_x_discrete(expand = c(0, 0),labels=lab) +
    scale_y_discrete(expand = c(0, 0)) +
    theme(axis.text.x = element_text(hjust=1,vjust=0.4))
  print(g1)
}

# Multi Dimensional Scaling 
mdsPlot <- function(d, fontsize){
  fontsize <- as.numeric(fontsize) # font size
  g1 <- ggplot(data=d, aes_string(x=names(d)[1], y=names(d)[2], group=names(d)[3], colour=names(d)[3])) + 
    theme_grey(base_size=fontsize) + theme(legend.position="top") +
    scale_fill_manual(values=c(clrs[1:(nlevels(d[,3]))])) + 
    scale_colour_manual(values=c(clrs[1:(nlevels(d[,3]))])) +
    geom_point(size=3)
  print(g1)
}