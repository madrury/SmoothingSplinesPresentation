cd R
Rscript main.R
cd -

cd tex
pdflatex --file-line-error --synctex=1 presentation.tex
cd -
