THESIS = mythesis

thesis: $(THESIS).tex *.tex *.bib
	pdflatex $(THESIS)
	biber $(THESIS)
	pdflatex $(THESIS)
	pdflatex $(THESIS)

clean:
	rm -f *.aux
	rm -f *.bbl
	rm -f *.bcf
	rm -f *.blg
	rm -f *.lof
	rm -f *.log
	rm -f *.lot
	rm -f *.out
	rm -f *.run.xml
	rm -f *.toc
