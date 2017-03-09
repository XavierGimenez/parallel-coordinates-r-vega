# parallel-coordinates-r-vega
Example of a workflow with datawrangling in R and a final visualization output in vega.js


From a multidimensional dataset to a parallel coordinates chart. Data wrangling phase dedicated to fix some inconsistent data and generate a csv and json versions of the curated dataset.

Then vega.js is used by calling the node.js utility vg2svg for rendering the static visualization image. vega



## Basic Setup and execution

### Installataon of vega.js

Vega needs to be installed in the main folder of the project, as follows (From https://github.com/vega/vega):

For a basic setup allowing you to build Vega and run examples,
clone `https://github.com/vega/vega` and run `npm install`.

Once installation is complete, use `npm run test` to run tests and
`npm run build` to build output files.

This repo (`vega`) includes web-based demos within the `test` folder. To run
these, launch a local webserver in the top-level directory for the repo
(e.g., `python -m SimpleHTTPServer 8000` for Python 2,
`python -m http.server 8000` for Python 3) and then point your browser to
the right place (e.g., `http://localhost:8000/test/`).


### Run makefile

Go to the bash and run the makafile to execute the whole process. That's it!