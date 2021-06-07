#
## EEBO Bib README

At 
[https://proquest.libguides.com/eebopqp/content](https://proquest.libguides.com/eebopqp/content) it is written: 
> “EEBO consists of facsimile images scanned from 4 major microfilm collections (issued by UMI) : 
> - Early English Books I (STC) 
> - Early English Books II (Wing) 
> - Thomason Tracts 
> - Early English Books Tract Supplement
> 
> together with rich descriptive bibliographic metadata containing Library of Congress Subject Headings and copious bibliographic references.  The current size of the collection amounts to over 146,000 works comprising more than 17 million pages of rare books. Over 60,000 EEBO texts, transcribed as part of the Text Creation Partnership project, are now included” 


A bit further on there is a link labelled “
[Title List November 2020](https://www.proquest.com/go/tls-eebo)”   from which you can (probably) download  an Excel spreadsheet in xslx format documenting all 146,000 titles.  Last August I  enriched this file with other bibliographic data from the UMI TCP site, and converted it to a simple TEI-conformant format, as further described 
[here](https://foxglove.hypotheses.org/601) and indeed
[here](https://foxglove.hypotheses.org/604).

This year I had occasion to update this file, and thought I should document the process more precisely. You can download my latest version of the EEBO-Bib file from
[here](https://app.box.com/s/3p6ft7xebsrp6rd6jv0lzde19tx28en5). You’re welcome. 

The scripts I used are in this repo, and here’s the workflow if you would like to replicate what I did.

### Prerequisites 

You need: 
- a local installation of 
[the TEI Stylesheets](https://tei-c.org/release/doc/tei-xsl/) (available from the
[TEI-C repository on Github](https://tei-c.org/guidelines/p5/using-the-tei-github-repository)) to get access to the `csvtotei` script
- [saxon](https://www.saxonica.com/html/products/products.html) or similar XSLT processor

Input datasets:
- the TLS spreadsheet as mentioned above. This should be downloadable from the address given above. But since it is HUGE some web browsers may give up prematurely. 
- some additional data extracted from the TCP `eebodat1` file. Available from this repository as `extracted.xml`
 
### Procedure
- Open the Proquest spreadsheet in whatever spreadsheet software you have to hand and save it as a csv file called e.g. `tls-eebo-2021.csv`
- Convert this to a pseudo-tei file called `tls-eebo-2021.xml` using the TEI `csvtotei` command
```
csvtotei tls-eebo-2021.csv
```
- convert this to proper TEI using the stylesheet `tcptotei.xsl` from this repo
```
saxon tls-eebo-2021.xml tcptotei.xsl > tls-eebo-2021-tei.xml
```
- enhance this  with relevant data from the file `extracted.xml` using the stylesheet `merge.xsl`, both available from this repo
```
    saxon tls-eebo-2021-tei.xml merge.xsl >tls-eebo-2021-plus.xml
```
This produces an enhanced version of the original tei:listBibl. If you're only interested in  entries for which a TCP transcription is proposed or exists, run it with a command line like this:
```
 saxon tls-eebo-2021-tei.xml merge.xsl subset=TCP >tls-eebo-2021-part.xml
```
which reduces the number of records from  146,914 to 143,353 and the size of the file from 136,667,050 to 133,799,514 bytes. Note however that it includes 83,167 titles slated for transcription in TCP but not yet available from UMI (or anywhere else) in transcribed form. The stylesheet `eebo-stats.xsl` produces these and other counts.
<!--
 146914 records in the PQ catalogue
        of which 
        143353 have TCP identifiers
        60186 are boxed up
        (25276 phase 1 and 34910 phase 2)
        The catalogue identifies
        60251  transcribed
        146422  imaged
        145453  with imageset identifiers-->

In either case, each `<bibl>` has the following additional attributes:
- @n if present, the title is or will be available as a TCP transcription. The attribute specifies both the identifier and the phase number e.g. “tcp1:A15814"
- @ref supplies the  ProQuest unique identifier (aka GOID) e.g. "proquest:2240876541"
- @xml:id supplies the identifier of the MARC catalogue entry from which details have been taken  e.g. "eebo:99839575"
- @facs supplies  an identifying number for the original microfilm image set e.g. "eeboIs:4007"
- @type says what type of object this is e.g. "Book" 
- @xml:lang supplies the main language of the text, using the appropriate ISO 639-3 code, rather than the text strings in the source e.g. "eng" rather than "English".

The bibl contains some or all of the following TEI elements:

- an `<idno@type=”STC”>` element for each catalogue entry in STC, Wing etc, giving its record number
- a `<series>` indicating the collection concerned
- a `<title>` containing the full title as supplied by Proquest
- an `<author>` containing (some version of) the author’s name
- publication details as given in the copy, marked up with `<pubDate>`, `<publisher>` and `<pubPlace>`
- a `<measure type=”pp”>` giving the page count
- one or more `<note>` elements, distinguished by @type attribute as follows:
- sourceLibrary : the library holding the copy microfilmed
- transcriptType : “text” if a transcript of the text is available; “image” if images are available
- keywords : describe the text and its topics

Here’s an sample EEBO Phase 1 record:

```
<bibl n="tcp1:A04899" ref="proquest:2240924186" xml:id="eebo:22145372"
facs="eeboIs:25167" type="Book" xml:lang="eng">
<series>Early English Books, 1475-1640 (STC)</series>
<title>Cochin-China containing many admirable rarities and singularities
of that countrey / extracted out of an Italian relation, lately presented 
to the Pope, by Christophoro Borri, that liued certaine yeeres there ; 
and published by Robert Ashley.</title>
<author>Borri, Cristoforo, 1583-1632.|Ashley, Robert, 1565-1641.</author>
<pubDate>1633</pubDate>
<publisher>Printed by Robert Raworth, for Richard Clutterbuck, and are to be sold at the signe of the Ball in Little-Brittaine</publisher>
<pubPlace>England</pubPlace>
<note type="keywords">Travel, topography, maps and navigational manuals|Religious</note>
<note type="sourceLibrary">Bodleian Library</note>
<note type="transcriptType">text image </note>
<note type="langNote">English</note>
<measure type="pp">36</measure>
</bibl>
```
### Visualising the text

Any item may be viewed online: in the Proquest interface, prefix the Proquest identifier (i.e. bibl/@ref value) with https://search.proquest.com/eebo/docview/  for example, to read the example cited, above, go to 
[https://search.proquest.com/eebo/docview/2240924186](https://search.proquest.com/eebo/docview/2240924186)
  
To use the JISC Historical Datasets interface, the eebo catalogue number (i.e. the bibl@xml:id value), is prefixed by “eebo-” or “eebo-ocm”, depending on the catalogue used, and suffixed by an “e” for reasons unknown, but time will tell.  For example, to read the same example go to 
[https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-ocm22145372e](https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-ocm22145372e)

### Wait, there's more

 This repository also contains a small number of other XSLT scripts written for a variety of housekeeping purposes. Specifically :
 
 - `eebo-stats.xsl` counts numbers of eebo bib records of various kinds
 - `addIds.xsl` does post-processing tidy-up of phase 2  SGML files to generate TEI P5 XML versions 
 - `termFreq.xsl` produces a frequency table of the descriptive keywords supplied by Proquest 
 - `extractData.xsl` processes full eebodat1.xml file to extract data missing from Proquest file
 - `getMeta.xsl` extracts minimal metadata (id, date, place, language) in csv format
 