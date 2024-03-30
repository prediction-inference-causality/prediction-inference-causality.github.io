#!/bin/sh


if [ -f "assignment-callout.lua" ] && [ -f "solution-callout.lua" ] ; then
   if [ -f "custom-callout.lua"  ] && ! [ -L "custom-callout.lua" ] ; then 
	quarto render $1;
   else
      rm -f custom-callout.lua;
      ln -s solution-callout.lua custom-callout.lua;
      quarto render $1;
      mv `basename $1 .qmd`.html `basename $1 .qmd`-solution.html;

      rm -f custom-callout.lua;
      ln -s assignment-callout.lua custom-callout.lua;
      quarto render $1;      
      
      rm -f custom-callout.lua;
      ln -s solution-callout.lua custom-callout.lua;
  fi
fi
	
