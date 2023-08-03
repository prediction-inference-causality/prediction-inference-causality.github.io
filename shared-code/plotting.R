library(ggplot2)

class.theme = theme(plot.background = element_rect(fill = "transparent", colour = NA),
		    panel.background = element_rect(fill = "transparent", colour = NA),
                    legend.background = element_rect(fill="transparent", colour = NA),
                    legend.box.background = element_rect(fill="transparent", colour = NA),
                    legend.key = element_rect(fill="transparent", colour = NA),
		    axis.ticks.x = element_blank(),
		    axis.ticks.y = element_blank(),
		    axis.text.x  = element_text(colour = "#aaaaaa"),
		    axis.text.y  = element_text(colour = "#aaaaaa"),
		    axis.title.x  = element_text(colour = "#aaaaaa"),
		    axis.title.y  = element_text(colour = "#aaaaaa", angle=90)
)
theme_set(class.theme)
theme_update(axis.title.x  = element_blank(),
             axis.title.y  = element_blank())
simplified.theme = theme_get()
theme_update(axis.text.x   = element_blank(), 
	     axis.text.y   = element_blank())
blank.theme = theme_get()
theme_update(panel.grid.major=element_line(color=rgb(1,0,0,.1,  maxColorValue=1)),
	     panel.grid.minor=element_line(color=rgb(0,1,0,.1, maxColorValue=1)))
grid.theme = theme_get()

savefig = function(filename) { 
    ggsave(filename, bg='transparent', width=7, height=4)
}

savefig.square = function(filename) { 
    ggsave(filename, bg='transparent', width=7, height=7)
}

savefig.both = function(filename) { 
    ggsave(filename, bg='transparent', width=7, height=7)
    ggsave(gsub("\\.pdf", "-7x4.pdf", filename), width=7, height=4)
}
