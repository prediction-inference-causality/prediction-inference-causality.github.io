library(IDPmisc)


node1 <- list(x=.14, y=.2, name="X", pch=16)
node2 <- list(x=.86, y=.2, name="Y", pch=16)
node3 <- list(x=.3, y=.5, name=expression(italic(Z[1])), pch=16)
node4 <- list(x=.7, y=.5, name=expression(italic(Z[2])), pch=1)
node5 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node6 <- list(x=.2, y=.8, name=expression(italic(U[2])), pch=16)
node7 <- list(x=.8, y=.8, name=expression(italic(U[4])), pch=1)
node8 <- list(x=.05, y=.4, name=expression(italic(U[3])), pch=1)
node9 <- list(x=.95, y=.4, name=expression(italic(U[5])), pch=1)


pdf("DAG1.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
par(mfrow=c(1,2))

plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(a)", cex.sub=2)

points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y-.06, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.06, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x-0.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x+.06, node4$y, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y+.06, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y+.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x, node8$y+.06, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x, node9$y+.06, node9$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE)

Arrows(node3$x, node3$y, node1$x, node1$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node2$x, node2$y, open=FALSE, sh.lty=1)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node8$x, node8$y, node1$x, node1$y, open=FALSE, sh.lty=2)
Arrows(node6$x, node6$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node9$x, node9$y, node2$x, node2$y, open=FALSE, sh.lty=2)

#Arrows(node5$x, node5$y, node2$x, node2$y, open=FALSE, sh.lty=2)
#Arrows(node6$x, node6$y, node1$x, node1$y, open=FALSE, sh.lty=2)
#Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node4$x, node4$y, pch=16, cex=1.5, col="white")
points(node4$x, node4$y, pch=node4$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

points(node6$x, node6$y, pch=16, cex=1.5, col="white")
points(node6$x, node6$y, pch=node6$pch, cex=1.5)

points(node7$x, node7$y, pch=16, cex=1.5, col="white")
points(node7$x, node7$y, pch=node7$pch, cex=1.5)

points(node8$x, node8$y, pch=16, cex=1.5, col="white")
points(node8$x, node8$y, pch=node8$pch, cex=1.5)

points(node9$x, node9$y, pch=16, cex=1.5, col="white")
points(node9$x, node9$y, pch=node9$pch, cex=1.5)







plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(b)", cex.sub=2)


points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y-.06, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.06, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x-0.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x+.06, node4$y, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y+.06, node5$name, cex=2, font=3)

#points(node6$x, node6$y, pch=node6$pch, cex=1.5)
#text(node6$x, node6$y+.06, node6$name, cex=2, font=3)

#points(node7$x, node7$y, pch=node7$pch, cex=1.5)
#text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

#points(node8$x, node8$y, pch=node8$pch, cex=1.5)
#text(node8$x, node8$y+.06, node8$name, cex=2, font=3)

#points(node9$x, node9$y, pch=node9$pch, cex=1.5)
#text(node9$x, node9$y+.06, node9$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE)

Arrows(node3$x, node3$y, node1$x, node1$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node2$x, node2$y, open=FALSE, sh.lty=1)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)
#Arrows(node8$x, node8$y, node1$x, node1$y, open=FALSE, sh.lty=2)
#Arrows(node6$x, node6$y, node3$x, node3$y, open=FALSE, sh.lty=2)
#Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)
#Arrows(node9$x, node9$y, node2$x, node2$y, open=FALSE, sh.lty=2)

#Arrows(node5$x, node5$y, node2$x, node2$y, open=FALSE, sh.lty=2)
#Arrows(node6$x, node6$y, node1$x, node1$y, open=FALSE, sh.lty=2)
#Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node4$x, node4$y, pch=16, cex=1.5, col="white")
points(node4$x, node4$y, pch=node4$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

#points(node6$x, node6$y, pch=16, cex=1.5, col="white")
#points(node6$x, node6$y, pch=node6$pch, cex=1.5)

#points(node7$x, node7$y, pch=16, cex=1.5, col="white")
#points(node7$x, node7$y, pch=node7$pch, cex=1.5)

#points(node8$x, node8$y, pch=16, cex=1.5, col="white")
#points(node8$x, node8$y, pch=node8$pch, cex=1.5)

#points(node9$x, node9$y, pch=16, cex=1.5, col="white")
#points(node9$x, node9$y, pch=node9$pch, cex=1.5)




dev.off()



## Twin Graph ##

node1 <- list(x=.3, y=.2, name="X", pch=16)
node2 <- list(x=.9, y=.2, name="Y", pch=16)
node3 <- list(x=.2, y=.8, name="Z", pch=16)
node4 <- list(x=.4, y=.9, name=expression(italic(U[1])), pch=1)
node5 <- list(x=.9, y=.5, name=expression(italic(U[3])), pch=1)
node6 <- list(x=.65, y=.7, name=expression(italic(U[2])), pch=1)

node7 <- list(x=.9, y=1.4, name=expression(x[0]), pch=16)
node8 <- list(x=1.1, y=.8, name=expression(Y(x[0])), pch=16)
node9 <- list(x=.4, y=1.2, name=expression(Z(x[0])), pch=16)

pdf("DAGTWIN.pdf", width=8, height=8, version="1.4", bg="white", pointsize=11,   family="Times")

plot(0, 0, xlim=c(.1,1.4), ylim=c(0,1.5), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y-.1, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.1, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x-.1, node3$y+.1, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y+.1, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y+.1, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y+.1, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x+.05, node7$y-.1, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x+.15, node8$y-.15, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x-.15, node9$y+.15, node9$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE)
Arrows(node3$x, node3$y, node1$x, node1$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node2$x, node2$y, open=FALSE, sh.lty=1)

Arrows(node4$x, node4$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node6$x, node6$y, node1$x, node1$y, open=FALSE, sh.lty=2)
#Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE)
#Arrows(node9$x, node9$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node9$x, node9$y, node8$x, node8$y, open=FALSE, sh.lty=1)

Arrows(node4$x, node4$y, node9$x, node9$y, open=FALSE, sh.lty=2)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=2)
#Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=2)
#Arrows(node5$x, node5$y, node9$x, node9$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node6$x, node6$y, node4$x, node4$y, open=FALSE, sh.lty=2)

points(node4$x, node4$y, pch=16, cex=1.5, col="white")
points(node4$x, node4$y, pch=node4$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

points(node6$x, node6$y, pch=16, cex=1.5, col="white")
points(node6$x, node6$y, pch=node6$pch, cex=1.5)

dev.off()





## Simple M structure graph

#node1 <- list(x=0, y=.9, name=expression(italic(U[1])), pch=1)
#node2 <- list(x=.45, y=.9, name=expression(italic(U[3])), pch=1)
#node3 <- list(x=.5, y=.6, name="Z", pch=16)
#node4 <- list(x=.6, y=.15, name="X", pch=16)
#node5 <- list(x=1, y=.1, name="Y", pch=16)
#node6 <- list(x=.26, y=.92, name=expression(italic(U[2])), pch=1)
#node7 <- list(x=.2, y=.3, name=expression(italic(U[4])), pch=1)
#node8 <- list(x=.92, y=.6, name=expression(italic(U[5])), pch=1)

node1 <- list(x=0, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=1, y=.9, name=expression(italic(U[3])), pch=1)
node3 <- list(x=.5, y=.6, name="Z", pch=16)
node4 <- list(x=0, y=.2, name="X", pch=16)
node5 <- list(x=1, y=.1, name="Y", pch=16)
node6 <- list(x=.5, y=.9, name=expression(italic(U[2])), pch=1)
node7 <- list(x=.2, y=.4, name=expression(italic(U[4])), pch=1)
node8 <- list(x=.8, y=.3, name=expression(italic(U[5])), pch=1)

pdf("DAG2.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
par(mfrow=c(1,2))


plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(a)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y-.05, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y+.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x, node8$y+.06, node8$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node5$x, node5$y, open=FALSE, sh.lty=1)

Arrows(node6$x, node6$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node8$x, node8$y, node5$x, node5$y, open=FALSE, sh.lty=2)



points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)

points(node6$x, node6$y, pch=16, cex=1.5, col="white")
points(node6$x, node6$y, pch=node6$pch, cex=1.5)
points(node7$x, node7$y, pch=16, cex=1.5, col="white")
points(node7$x, node7$y, pch=node7$pch, cex=1.5)
points(node8$x, node8$y, pch=16, cex=1.5, col="white")
points(node8$x, node8$y, pch=node8$pch, cex=1.5)




plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(b)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y-.05, node5$name, cex=2, font=3)



Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node5$x, node5$y, open=FALSE, sh.lty=1)



points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)



dev.off()

## M-structure for Talk ##

node1 <- list(x=0, y=.9, name="Parental Ethnocentrism", pch=1)
node2 <- list(x=1, y=.9, name="Student Intelligence", pch=1)
node3 <- list(x=.5, y=.6, name="Student Reported Ethnocentrism", pch=16)
node4 <- list(x=0, y=.2, name="Exposure", pch=16)
node5 <- list(x=1, y=.1, name="Offer", pch=16)
#node1 <- list(x=0, y=.9, name=expression(italic(Z[1])), pch=1)
#node2 <- list(x=1, y=.9, name=expression(italic(Z[2])), pch=1)
#node3 <- list(x=.5, y=.6, name=expression(italic(Z[3])), pch=16)
#node4 <- list(x=0, y=.2, name=expression(italic(X)), pch=16)
#node5 <- list(x=1, y=.1, name=expression(italic(Y)), pch=16)
node6 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node7 <- list(x=.2, y=.4, name=expression(italic(U[2])), pch=1)
node8 <- list(x=.8, y=.3, name=expression(italic(U[3])), pch=1)

pdf("DAG2talk.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")

plot(0, 0, xlim=c(-.15,1.15), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x, node5$y-.05, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y+.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x, node8$y+.06, node8$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node4$x, node4$y, node5$x, node5$y, open=FALSE, sh.lty=1)

Arrows(node6$x, node6$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node8$x, node8$y, node5$x, node5$y, open=FALSE, sh.lty=2)



points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)

points(node6$x, node6$y, pch=16, cex=1.5, col="white")
points(node6$x, node6$y, pch=node6$pch, cex=1.5)
points(node7$x, node7$y, pch=16, cex=1.5, col="white")
points(node7$x, node7$y, pch=node7$pch, cex=1.5)
points(node8$x, node8$y, pch=16, cex=1.5, col="white")
points(node8$x, node8$y, pch=node8$pch, cex=1.5)

dev.off()

## Post-Treatment Graph ##
node1a <- list(x=.5, y=.9, name=expression(italic(U)), pch=1)
node1 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.1, y=.3, name="X", pch=16)
node3 <- list(x=.5, y=.2, name="Z", pch=16)
node4 <- list(x=.9, y=.1, name="Y", pch=16)
node5 <- list(x=.5, y=.5, name=expression(italic(U[2])), pch=1)


pdf("DAGpost0.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")



plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.025, node5$y+.05, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


#Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

dev.off()

pdf("DAGpost1.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")



plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.025, node5$y+.05, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5, col="coral")
text(node3$x, node3$y-.05, node3$name, cex=2, font=3,col="coral")

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


#Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1, sh.col="cornflowerblue")
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

dev.off()


## Front Door Graph IQMR ##
node1a <- list(x=.5, y=.9, name=expression(italic(U)), pch=1)
node1 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.1, y=.3, name="X", pch=16)
node3 <- list(x=.5, y=.2, name="Z", pch=16)
node4 <- list(x=.9, y=.1, name="Y", pch=16)
node5 <- list(x=.5, y=.5, name=expression(italic(U[2])), pch=1)


pdf("DAG3iqmr.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.025, node5$y+.05, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

dev.off()


## Front Door Graph ##
node1a <- list(x=.5, y=.9, name=expression(italic(U)), pch=1)
node1 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.1, y=.3, name="X", pch=16)
node3 <- list(x=.5, y=.2, name="Z", pch=16)
node4 <- list(x=.9, y=.1, name="Y", pch=16)
node5 <- list(x=.5, y=.5, name=expression(italic(U[2])), pch=1)


pdf("DAG3.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
par(mfrow=c(1,2))


plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(a)", cex.sub=2)

points(node1a$x, node1a$y, pch=node1a$pch, cex=1.5)
text(node1a$x+.025, node1a$y+.05, node1a$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


Arrows(node1a$x, node1a$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1a$x, node1a$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=1)
points(node1a$x, node1a$y, pch=16, cex=1.5, col="white")
points(node1a$x, node1a$y, pch=node1$pch, cex=1.5)

plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(b)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.025, node5$y+.05, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

dev.off()



## Front Door Graph a ##
node1 <- list(x=.5, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.1, y=.3, name="X", pch=16)
node3 <- list(x=.5, y=.2, name="Z", pch=16)
node4 <- list(x=.9, y=.1, name="Y", pch=16)
node5 <- list(x=.5, y=.5, name=expression(italic(U[3])), pch=1)
node6 <- list(x=.1, y=.6, name=expression(italic(U[2])), pch=1)
node7 <- list(x=.9, y=.4, name=expression(italic(U[4])), pch=1)


pdf("DAG3a.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
par(mfrow=c(1,2))
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(a)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.06, node1$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.025, node5$y+.06, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.06, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.06, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.06, node4$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y+.06, node6$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)

Arrows(node6$x, node6$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

points(node5$x, node5$y, pch=16, cex=1.5, col="white")
points(node5$x, node5$y, pch=node5$pch, cex=1.5)

points(node6$x, node6$y, pch=16, cex=1.5, col="white")
points(node6$x, node6$y, pch=node6$pch, cex=1.5)

points(node7$x, node7$y, pch=16, cex=1.5, col="white")
points(node7$x, node7$y, pch=node7$pch, cex=1.5)




plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(b)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.06, node1$name, cex=2, font=3)

#points(node5$x, node5$y, pch=node5$pch, cex=1.5)
#text(node5$x+.025, node5$y+.06, node5$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.06, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.06, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.06, node4$name, cex=2, font=3)

#points(node7$x, node7$y, pch=node7$pch, cex=1.5)
#text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

#points(node6$x, node6$y, pch=node6$pch, cex=1.5)
#text(node6$x, node6$y+.06, node6$name, cex=2, font=3)


Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)

#Arrows(node5$x, node5$y, node3$x, node3$y, open=FALSE, sh.lty=2)
#Arrows(node6$x, node6$y, node2$x, node2$y, open=FALSE, sh.lty=2)
#Arrows(node7$x, node7$y, node4$x, node4$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)

#points(node5$x, node5$y, pch=16, cex=1.5, col="white")
#points(node5$x, node5$y, pch=node5$pch, cex=1.5)

#points(node6$x, node6$y, pch=16, cex=1.5, col="white")
#points(node6$x, node6$y, pch=node6$pch, cex=1.5)

#points(node7$x, node7$y, pch=16, cex=1.5, col="white")
#points(node7$x, node7$y, pch=node7$pch, cex=1.5)

dev.off()





node1 <- list(x=0, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.7, y=.85, name=expression(italic(U[2])), pch=1)
node3 <- list(x=.05, y=.6, name=expression(italic(Z[1])), pch=16)
node4 <- list(x=.5, y=.55, name=expression(italic(Z[2])), pch=16)
node5 <- list(x=.9, y=.5, name=expression(italic(Z[3])), pch=16)
node6 <- list(x=.2, y=.15, name="X", pch=16)
node7 <- list(x=.6, y=.125, name=expression(italic(Y[1])), pch=16)
node8 <- list(x=1, y=.1, name=expression(italic(Y[2])), pch=16)


pdf("DAG4.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x-.05, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x-.02, node4$y+.085, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x+.06, node5$y, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x, node6$y-.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y-.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x, node8$y-.06, node8$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node3$x, node3$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE, sh.lty=1)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)


dev.off()


## Post Treatment in Time Graph ##


node1 <- list(x=0, y=.95, name="U", pch=1)
node2 <- list(x=.925, y=.3, name="Z", pch=16)
node3 <- list(x=.1, y=.5, name="X", pch=16)
node4 <- list(x=1, y=.05, name="Y", pch1=16)

pdf("DAG5.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x+.02, node2$y+.06, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)



Arrows(node1$x, node1$y, node2$x, node2$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)


dev.off()




## IV Graph ##


node1 <- list(x=.65, y=.7, name="U", pch=1)
node2 <- list(x=.1, y=.3, name="Z", pch=16)
node3 <- list(x=.5, y=.2, name="X", pch=16)
node4 <- list(x=.9, y=.1, name="Y", pch=16)


pdf("DAG6.pdf", width=6, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y-.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x, node3$y-.05, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x, node4$y-.05, node4$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node3$x, node3$y, open=FALSE, sh.lty=1)
Arrows(node3$x, node3$y, node4$x, node4$y, open=FALSE, sh.lty=1)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)


dev.off()






node1 <- list(x=.1, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.7, y=.9, name=expression(italic(U[3])), pch=1)
node3 <- list(x=.15, y=.675, name=expression(italic(Z[1])), pch=16)
node4 <- list(x=.5, y=.65, name=expression(italic(Z[2])), pch=16)
node5 <- list(x=.82, y=.625, name=expression(italic(Z[3])), pch=16)
node6 <- list(x=.2, y=.45, name="X", pch=16)
node7 <- list(x=.6, y=.425, name=expression(italic(Z[5])), pch=16)
node8 <- list(x=.90, y=.4, name=expression(italic(Y)), pch=16)
node9 <- list(x=.2, y=.1, name=expression(italic(U[9])), pch=1)
node10 <- list(x=.7, y=.1, name=expression(italic(U[11])), pch=1)
node11 <- list(x=.4, y=.25, name=expression(italic(Z[4])), pch=16)

node12 <- list(x=.45, y=.92, name=expression(italic(U[2])), pch=1)
node13 <- list(x=.9, y=.8, name=expression(italic(U[5])), pch=1)
node14 <- list(x=.04, y=.75, name=expression(italic(U[4])), pch=1)
node15 <- list(x=.025, y=.45, name=expression(italic(U[6])), pch=1)
node16 <- list(x=.65, y=.25, name=expression(italic(U[7])), pch=1)
node17 <- list(x=.45, y=.06, name=expression(italic(U[10])), pch=1)
node18 <- list(x=.95, y=.2, name=expression(italic(U[8])), pch=1)



pdf("DAG7.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
par(mfrow=c(1,2))
plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(a)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x+.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x-.1, node4$y+.0, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x-.06, node5$y, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x+.05, node6$y-.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x+.031, node8$y+.06, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x, node9$y-.06, node9$name, cex=2, font=3)

points(node10$x, node10$y, pch=node10$pch, cex=1.5)
text(node10$x, node10$y-.06, node10$name, cex=2, font=3)

points(node11$x, node11$y, pch=node11$pch, cex=1.5)
text(node11$x, node11$y+.06, node11$name, cex=2, font=3)

points(node12$x, node12$y, pch=node12$pch, cex=1.5)
text(node12$x, node12$y+.06, node12$name, cex=2, font=3)

points(node13$x, node13$y, pch=node13$pch, cex=1.5)
text(node13$x, node13$y+.06, node13$name, cex=2, font=3)

points(node14$x, node14$y, pch=node14$pch, cex=1.5)
text(node14$x, node14$y+.06, node14$name, cex=2, font=3)

points(node15$x, node15$y, pch=node15$pch, cex=1.5)
text(node15$x, node15$y+.06, node15$name, cex=2, font=3)

points(node16$x, node16$y, pch=node16$pch, cex=1.5)
text(node16$x-.06, node16$y+.0, node16$name, cex=2, font=3)

points(node17$x, node17$y, pch=node17$pch, cex=1.5)
text(node17$x-.0, node17$y-.06, node17$name, cex=2, font=3)

points(node18$x, node18$y, pch=node18$pch, cex=1.5)
text(node18$x-.0, node18$y-.06, node18$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node3$x, node3$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE, sh.lty=1)

Arrows(node9$x, node9$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node9$x, node9$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node8$x, node8$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node11$x, node11$y, open=FALSE, sh.lty=2)

Arrows(node12$x, node12$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node13$x, node13$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node14$x, node14$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node15$x, node15$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node16$x, node16$y, node7$x, node7$y, open=FALSE, sh.lty=2)
Arrows(node17$x, node17$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node18$x, node18$y, node8$x, node8$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)
points(node9$x, node9$y, pch=16, cex=1.5, col="white")
points(node9$x, node9$y, pch=node9$pch, cex=1.5)
points(node10$x, node10$y, pch=16, cex=1.5, col="white")
points(node10$x, node10$y, pch=node10$pch, cex=1.5)

points(node12$x, node12$y, pch=16, cex=1.5, col="white")
points(node12$x, node12$y, pch=node12$pch, cex=1.5)
points(node13$x, node13$y, pch=16, cex=1.5, col="white")
points(node13$x, node13$y, pch=node13$pch, cex=1.5)
points(node14$x, node14$y, pch=16, cex=1.5, col="white")
points(node14$x, node14$y, pch=node14$pch, cex=1.5)
points(node15$x, node15$y, pch=16, cex=1.5, col="white")
points(node15$x, node15$y, pch=node15$pch, cex=1.5)
points(node16$x, node16$y, pch=16, cex=1.5, col="white")
points(node16$x, node16$y, pch=node16$pch, cex=1.5)
points(node17$x, node17$y, pch=16, cex=1.5, col="white")
points(node17$x, node17$y, pch=node17$pch, cex=1.5)
points(node18$x, node18$y, pch=16, cex=1.5, col="white")
points(node18$x, node18$y, pch=node18$pch, cex=1.5)




plot(0, 0, xlim=c(0,1), ylim=c(0,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", sub="(b)", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x+.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x-.1, node4$y+.0, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x-.06, node5$y, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x+.05, node6$y-.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x+.031, node8$y+.06, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x, node9$y-.06, node9$name, cex=2, font=3)

points(node10$x, node10$y, pch=node10$pch, cex=1.5)
text(node10$x, node10$y-.06, node10$name, cex=2, font=3)

points(node11$x, node11$y, pch=node11$pch, cex=1.5)
text(node11$x, node11$y+.06, node11$name, cex=2, font=3)



Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node3$x, node3$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE, sh.lty=1)

Arrows(node9$x, node9$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node9$x, node9$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node8$x, node8$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node11$x, node11$y, open=FALSE, sh.lty=2)


points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)
points(node9$x, node9$y, pch=16, cex=1.5, col="white")
points(node9$x, node9$y, pch=node9$pch, cex=1.5)
points(node10$x, node10$y, pch=16, cex=1.5, col="white")
points(node10$x, node10$y, pch=node10$pch, cex=1.5)



dev.off()

## Complicated M-structure for Talk ##

node1 <- list(x=.1, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.7, y=.9, name=expression(italic(U[3])), pch=1)
node3 <- list(x=.15, y=.675, name=expression(italic(Z[1])), pch=16)
node4 <- list(x=.5, y=.65, name=expression(italic(Z[2])), pch=16)
node5 <- list(x=.82, y=.625, name=expression(italic(Z[3])), pch=16)
node6 <- list(x=.2, y=.45, name="X", pch=16)
node7 <- list(x=.6, y=.425, name=expression(italic(Z[5])), pch=16)
node8 <- list(x=.90, y=.4, name=expression(italic(Y)), pch=16)
node9 <- list(x=.2, y=.1, name=expression(italic(U[9])), pch=1)
node10 <- list(x=.7, y=.1, name=expression(italic(U[11])), pch=1)
node11 <- list(x=.4, y=.25, name=expression(italic(Z[4])), pch=16)

node12 <- list(x=.45, y=.92, name=expression(italic(U[2])), pch=1)
node13 <- list(x=.9, y=.8, name=expression(italic(U[5])), pch=1)
node14 <- list(x=.04, y=.75, name=expression(italic(U[4])), pch=1)
node15 <- list(x=.025, y=.45, name=expression(italic(U[6])), pch=1)
node16 <- list(x=.65, y=.25, name=expression(italic(U[7])), pch=1)
node17 <- list(x=.45, y=.06, name=expression(italic(U[10])), pch=1)
node18 <- list(x=.95, y=.2, name=expression(italic(U[8])), pch=1)



pdf("DAG7talk.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
    
plot(0, 0, xlim=c(0,1), ylim=c(-.03,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x+.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x-.1, node4$y+.0, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x-.06, node5$y, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x+.05, node6$y-.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x+.031, node8$y+.06, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x, node9$y-.06, node9$name, cex=2, font=3)

points(node10$x, node10$y, pch=node10$pch, cex=1.5)
text(node10$x, node10$y-.06, node10$name, cex=2, font=3)

points(node11$x, node11$y, pch=node11$pch, cex=1.5)
text(node11$x, node11$y+.06, node11$name, cex=2, font=3)

points(node12$x, node12$y, pch=node12$pch, cex=1.5)
text(node12$x, node12$y+.06, node12$name, cex=2, font=3)

points(node13$x, node13$y, pch=node13$pch, cex=1.5)
text(node13$x, node13$y+.06, node13$name, cex=2, font=3)

points(node14$x, node14$y, pch=node14$pch, cex=1.5)
text(node14$x, node14$y+.06, node14$name, cex=2, font=3)

points(node15$x, node15$y, pch=node15$pch, cex=1.5)
text(node15$x, node15$y+.06, node15$name, cex=2, font=3)

points(node16$x, node16$y, pch=node16$pch, cex=1.5)
text(node16$x-.06, node16$y+.0, node16$name, cex=2, font=3)

points(node17$x, node17$y, pch=node17$pch, cex=1.5)
text(node17$x-.0, node17$y-.06, node17$name, cex=2, font=3)

points(node18$x, node18$y, pch=node18$pch, cex=1.5)
text(node18$x-.0, node18$y-.06, node18$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node3$x, node3$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE, sh.lty=1)

Arrows(node9$x, node9$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node9$x, node9$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node8$x, node8$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node11$x, node11$y, open=FALSE, sh.lty=2)

Arrows(node12$x, node12$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node13$x, node13$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node14$x, node14$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node15$x, node15$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node16$x, node16$y, node7$x, node7$y, open=FALSE, sh.lty=2)
Arrows(node17$x, node17$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node18$x, node18$y, node8$x, node8$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)
points(node9$x, node9$y, pch=16, cex=1.5, col="white")
points(node9$x, node9$y, pch=node9$pch, cex=1.5)
points(node10$x, node10$y, pch=16, cex=1.5, col="white")
points(node10$x, node10$y, pch=node10$pch, cex=1.5)

points(node12$x, node12$y, pch=16, cex=1.5, col="white")
points(node12$x, node12$y, pch=node12$pch, cex=1.5)
points(node13$x, node13$y, pch=16, cex=1.5, col="white")
points(node13$x, node13$y, pch=node13$pch, cex=1.5)
points(node14$x, node14$y, pch=16, cex=1.5, col="white")
points(node14$x, node14$y, pch=node14$pch, cex=1.5)
points(node15$x, node15$y, pch=16, cex=1.5, col="white")
points(node15$x, node15$y, pch=node15$pch, cex=1.5)
points(node16$x, node16$y, pch=16, cex=1.5, col="white")
points(node16$x, node16$y, pch=node16$pch, cex=1.5)
points(node17$x, node17$y, pch=16, cex=1.5, col="white")
points(node17$x, node17$y, pch=node17$pch, cex=1.5)
points(node18$x, node18$y, pch=16, cex=1.5, col="white")
points(node18$x, node18$y, pch=node18$pch, cex=1.5)


dev.off()


node1 <- list(x=.1, y=.9, name=expression(italic(U[1])), pch=1)
node2 <- list(x=.7, y=.9, name=expression(italic(U[3])), pch=1)
node3 <- list(x=.15, y=.675, name=expression(italic(Z[1])), pch=16)
node4 <- list(x=.5, y=.65, name=expression(italic(Z[2])), pch=16)
node5 <- list(x=.82, y=.625, name=expression(italic(Z[3])), pch=16)
node6 <- list(x=.2, y=.45, name="X", pch=16)
node7 <- list(x=.6, y=.425, name=expression(italic(Z[5])), pch=16)
node8 <- list(x=.90, y=.4, name=expression(italic(Y)), pch=16)
node9 <- list(x=.2, y=.1, name=expression(italic(U[9])), pch=1)
node10 <- list(x=.7, y=.1, name=expression(italic(U[11])), pch=1)
node11 <- list(x=.4, y=.25, name=expression(italic(Z[4])), pch=16)

node12 <- list(x=.45, y=.92, name=expression(italic(U[2])), pch=1)
node13 <- list(x=.9, y=.8, name=expression(italic(U[5])), pch=1)
node14 <- list(x=.04, y=.75, name=expression(italic(U[4])), pch=1)
node15 <- list(x=.025, y=.45, name=expression(italic(U[6])), pch=1)
node16 <- list(x=.65, y=.25, name=expression(italic(U[7])), pch=1)
node17 <- list(x=.45, y=.06, name=expression(italic(U[10])), pch=1)
node18 <- list(x=.95, y=.2, name=expression(italic(U[8])), pch=1)

## Submodel for Talk ##

pdf("DAG7subtalk.pdf", width=12, height=6, version="1.4", bg="white", pointsize=11,
    family="Times")
    
plot(0, 0, xlim=c(0,1), ylim=c(-.03,1), type="n", xlab="", ylab="", main="",
     bty="n", xaxt="n", yaxt="n", cex.sub=2)
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
text(node1$x+.025, node1$y+.05, node1$name, cex=2, font=3)

points(node2$x, node2$y, pch=node2$pch, cex=1.5)
text(node2$x, node2$y+.05, node2$name, cex=2, font=3)

points(node3$x, node3$y, pch=node3$pch, cex=1.5)
text(node3$x+.06, node3$y, node3$name, cex=2, font=3)

points(node4$x, node4$y, pch=node4$pch, cex=1.5)
text(node4$x-.1, node4$y+.0, node4$name, cex=2, font=3)

points(node5$x, node5$y, pch=node5$pch, cex=1.5)
text(node5$x-.06, node5$y, node5$name, cex=2, font=3)

points(node6$x, node6$y, pch=node6$pch, cex=1.5)
text(node6$x+.05, node6$y-.06, node6$name, cex=2, font=3)

points(node7$x, node7$y, pch=node7$pch, cex=1.5)
text(node7$x, node7$y+.06, node7$name, cex=2, font=3)

points(node8$x, node8$y, pch=node8$pch, cex=1.5)
text(node8$x+.031, node8$y+.06, node8$name, cex=2, font=3)

points(node9$x, node9$y, pch=node9$pch, cex=1.5)
text(node9$x, node9$y-.06, node9$name, cex=2, font=3)

points(node10$x, node10$y, pch=node10$pch, cex=1.5)
text(node10$x, node10$y-.06, node10$name, cex=2, font=3)

points(node11$x, node11$y, pch=node11$pch, cex=1.5)
text(node11$x, node11$y+.06, node11$name, cex=2, font=3)

points(node12$x, node12$y, pch=node12$pch, cex=1.5)
text(node12$x, node12$y+.06, node12$name, cex=2, font=3)

points(node13$x, node13$y, pch=node13$pch, cex=1.5)
text(node13$x, node13$y+.06, node13$name, cex=2, font=3)

points(node14$x, node14$y, pch=node14$pch, cex=1.5)
text(node14$x, node14$y+.06, node14$name, cex=2, font=3)

points(node15$x, node15$y, pch=node15$pch, cex=1.5)
text(node15$x, node15$y+.06, node15$name, cex=2, font=3)

points(node16$x, node16$y, pch=node16$pch, cex=1.5)
text(node16$x-.06, node16$y+.0, node16$name, cex=2, font=3)

points(node17$x, node17$y, pch=node17$pch, cex=1.5)
text(node17$x-.0, node17$y-.06, node17$name, cex=2, font=3)

points(node18$x, node18$y, pch=node18$pch, cex=1.5)
text(node18$x-.0, node18$y-.06, node18$name, cex=2, font=3)


Arrows(node1$x, node1$y, node3$x, node3$y, open=FALSE, sh.lty=2)
Arrows(node1$x, node1$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node2$x, node2$y, node5$x, node5$y, open=FALSE, sh.lty=2)
#Arrows(node3$x, node3$y, node6$x, node6$y, open=FALSE, sh.lty=1)
#Arrows(node4$x, node4$y, node6$x, node6$y, open=FALSE, sh.lty=1)
Arrows(node4$x, node4$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node5$x, node5$y, node8$x, node8$y, open=FALSE, sh.lty=1)
Arrows(node6$x, node6$y, node7$x, node7$y, open=FALSE, sh.lty=1)
Arrows(node7$x, node7$y, node8$x, node8$y, open=FALSE, sh.lty=1)

#Arrows(node9$x, node9$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node9$x, node9$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node8$x, node8$y, open=FALSE, sh.lty=2)
Arrows(node10$x, node10$y, node11$x, node11$y, open=FALSE, sh.lty=2)

Arrows(node12$x, node12$y, node4$x, node4$y, open=FALSE, sh.lty=2)
Arrows(node13$x, node13$y, node5$x, node5$y, open=FALSE, sh.lty=2)
Arrows(node14$x, node14$y, node3$x, node3$y, open=FALSE, sh.lty=2)
#Arrows(node15$x, node15$y, node6$x, node6$y, open=FALSE, sh.lty=2)
Arrows(node16$x, node16$y, node7$x, node7$y, open=FALSE, sh.lty=2)
Arrows(node17$x, node17$y, node11$x, node11$y, open=FALSE, sh.lty=2)
Arrows(node18$x, node18$y, node8$x, node8$y, open=FALSE, sh.lty=2)

points(node1$x, node1$y, pch=16, cex=1.5, col="white")
points(node1$x, node1$y, pch=node1$pch, cex=1.5)
points(node2$x, node2$y, pch=16, cex=1.5, col="white")
points(node2$x, node2$y, pch=node2$pch, cex=1.5)
points(node9$x, node9$y, pch=16, cex=1.5, col="white")
points(node9$x, node9$y, pch=node9$pch, cex=1.5)
points(node10$x, node10$y, pch=16, cex=1.5, col="white")
points(node10$x, node10$y, pch=node10$pch, cex=1.5)

points(node12$x, node12$y, pch=16, cex=1.5, col="white")
points(node12$x, node12$y, pch=node12$pch, cex=1.5)
points(node13$x, node13$y, pch=16, cex=1.5, col="white")
points(node13$x, node13$y, pch=node13$pch, cex=1.5)
points(node14$x, node14$y, pch=16, cex=1.5, col="white")
points(node14$x, node14$y, pch=node14$pch, cex=1.5)
points(node15$x, node15$y, pch=16, cex=1.5, col="white")
points(node15$x, node15$y, pch=node15$pch, cex=1.5)
points(node16$x, node16$y, pch=16, cex=1.5, col="white")
points(node16$x, node16$y, pch=node16$pch, cex=1.5)
points(node17$x, node17$y, pch=16, cex=1.5, col="white")
points(node17$x, node17$y, pch=node17$pch, cex=1.5)
points(node18$x, node18$y, pch=16, cex=1.5, col="white")
points(node18$x, node18$y, pch=node18$pch, cex=1.5)


dev.off()

