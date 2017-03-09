## the data analysis code source dir
DATA_WRANGLING_DIR=./data-process

DATA_VIZ_DIR=./data-viz


all:
	# r making some data wrangling
	cd $(DATA_WRANGLING_DIR); Rscript main.R; cd ..; pwd
	
	#call vega to generate the viz
	vega/bin/vg2svg parallel-coordinates.vg.json parallel-coordinates.svg
