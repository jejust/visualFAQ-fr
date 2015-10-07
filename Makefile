#########################################
# Build the Visual LaTeX FAQ		#
# By Scott Pakin <scott+vfaq@pakin.org> #
#########################################

DIST_SOURCES = \
	anotherarticle.pdf \
	book-montage.png \
	fuzzytext.png \
	labelgraph.pdf \
	lorem-ipsum-logo.png \
	musixtex.png \
	visfaq-html.png \
	visualFAQ.ind \
	visualFAQ.ind2 \
	visualFAQ.tex \
	watermark.pdf

%.pdf: %.eps
	ps2pdf -dEPSCrop $<

all: visualFAQ.pdf

visualFAQ.pdf: $(DIST_SOURCES)
	pdflatex '\let\vlfpoweruser=1\input visualFAQ'
	pdflatex '\let\vlfpoweruser=1\input visualFAQ'

anotherarticle.dvi: anotherarticle.tex
	latex anotherarticle.tex

anotherarticle.eps: anotherarticle.dvi
	dvips -E -o anotherarticle.eps anotherarticle.dvi

watermark.eps: watermark.odg
	libreoffice --headless --convert-to eps watermark.odg
	perl -i -ne 'BEGIN {chomp($$bbox=`gs -q -sDEVICE=bbox -dNOPAUSE -dBATCH watermark.eps 2>&1`)} s/^\%\%BoundingBox.*/$$bbox/; print' watermark.eps

labelgraph.eps labelgraph.tex: labelgraph.gp
	gnuplot labelgraph.gp -e 'set term epslatex col solid size 5,3 linewidth 2; set output "labelgraph.eps"; replot'

troubleshoot-vlf.pdf: troubleshoot-vlf.tex
	pdflatex troubleshoot-vlf.tex
	pdflatex troubleshoot-vlf.tex

dist: visualFAQ.tar.gz

visualFAQ.tar.gz: all README troubleshoot-vlf.pdf
	mkdir visualFAQ
	cp README visualFAQ.pdf troubleshoot-vlf.pdf visualFAQ/
	mkdir visualFAQ/source
	cp README-SRC visualFAQ/source/README
	cp $(DIST_SOURCES) visualFAQ/source/
	tar -czvf visualFAQ.tar.gz visualFAQ
	$(RM) -r visualFAQ

clean:
	$(RM) -r visualFAQ
	$(RM) visualFAQ.pdf visualFAQ.aux visualFAQ.log visualFAQ.out
	$(RM) troubleshoot-vlf.pdf
	$(RM) troubleshoot-vlf.out troubleshoot-vlf.aux troubleshoot-vlf.log
	$(RM) anotherarticle.aux anotherarticle.dvi anotherarticle.eps
	$(RM) anotherarticle.log anotherarticle.pdf
	$(RM) watermark.eps watermark.pdf
	$(RM) labelgraph.tex labelgraph.eps labelgraph.tex
