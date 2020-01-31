
SGMLOPTS = -c latin --language=de
CVSROOT = :local:/home/mbudde/dlhp/CVS


# how to convert a sgml file to other formats

%.txt: %.sgml
	sgml2txt -f $(SGMLOPTS) $<
%.html: %.sgml
	sgml2html -I $(SGMLOPTS) $<
%.tex: %.sgml
	sgml2latex -o tex $(SGMLOPTS) $<
%.dvi: %.sgml
	sgml2latex -o dvi $(SGMLOPTS) $<
%.ps: %.sgml
	sgml2latex -o ps $(SGMLOPTS) $<
%.pdf: %.sgml
	sgml2latex -o pdf $(SGMLOPTS) $<


# list of files

TXT := $(patsubst %.sgml,%.txt,$(wildcard *.sgml))
HTML := $(patsubst %.sgml,%.html,$(wildcard *.sgml))
TEX := $(patsubst %.sgml,%.tex,$(wildcard *.sgml))
DVI := $(patsubst %.sgml,%.dvi,$(wildcard *.sgml))
PS := $(patsubst %.sgml,%.ps,$(wildcard *.sgml))
PDF := $(patsubst %.sgml,%.pdf,$(wildcard *.sgml))
SGML := $(wildcard *.sgml)


all: txt html pdf ps dvi

txt: $(TXT)
html: $(HTML)
tex: $(TEX)
dvi: $(DVI)
ps: $(PS)
pdf: $(PDF)

archiv: all
	gzip $(TXT) $(DVI) $(PS) $(PDF) $(SGML)
	echo "HTML muß per Hand archiviert werden!"

clean:
	rm -f *.txt *.html *.tex *.dvi *.ps *.pdf
	rm -f *.txt.gz *.html.tar.gz *.dvi.gz *.ps.gz *.pdf.gz
	rm -f *~

cvs:
	cvs -d $(CVSROOT) checkout HOWTO/$(SGML)
	cp $(SGML) HOWTO/$(SGML)
	cvs -d $(CVSROOT) commit HOWTO/$(SGML) 
	rm -rf HOWTO/

cvs-mini:
	cvs -d $(CVSROOT) checkout mini-HOWTO/$(SGML)
	cp $(SGML) mini-HOWTO/$(SGML)
	cvs -d $(CVSROOT) commit mini-HOWTO/$(SGML) 
	rm -rf mini-HOWTO/

