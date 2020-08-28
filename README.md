# eebo-bib
## EEBO Bibliography in TEI

There you are idly scrolling through Twitter when someone announces a tempting resource that’s just crying out for TEI-ification. And there goes the afternoon and most of the evening.

Anyway, creating my EEBO Bibliography in TEI was insultingly easy. I just grabbed the Excel spreadsheet (34 Mb) thoughtfully created by those lovely people at Protext, and even more thoughtfully publicized by the even more lovely Heather Froelich on twitter this morning. I opened it up in Open Office. I exported it as a CSV file (85 Mb) and munged same through the standard TEI cvstotei stylesheet to generate 175 Mb of TEI compatible data. Then I sat down to consider how to make it actually TEI conformant, i.e. how to make the title of a bibliographic entry appear not as the content of <cell n= »5″> but as the content of a …. <title>. As you might suppose, defining the right mapping was easy for some things, but less so for others of the 17 cells in each of the 146,323 rows of the spreadsheet. There’s a table to show the mapping I decided on at the end of this blog, for those unwilling to read my pellucid XSLT code which actually uses it.

The resulting TEI file isn’t quite complete because it doesn’t have a TEI Header, needed to define the prefixes I use to save space in the URLs, but (at 120 Mb) it’s too big for github. And it’s now available at https://app.box.com/s/r8sxc68239g6pen09blzmul93tqs8rbv for your xpathing pleasure.

Here’s the table. The whole spreadsheet is a <listBibl> and each row becomes a <bibl>. I like simple solutions. I’m not proud of the <note type= "foo"s, but that’s the best I could think of without getting far too complicated.

|--|--|--|
|1|MARC identifier	|	@xml:id : prefixed by eebo:
|2|Image set identifier		|@facs : prefixed by eeboIs:
|3	|	Publication type		|@type (always either Book or Issue)
|4		|Collection 		|<series>
|5		|Title		|<title>
|6 		|Author		|<author>
|7		|Publication Date		|<pubDate>
|8		|Publisher		|<publisher>
|9		|Country name		|<pubPlace>
|10		|Publication language		|@xml:lang gives ISO code equivalent; text goes in a<note type= »langNote »> c
|11		|Accession number		|<idno>
|12		|Source Library		|<note type= »sourceLibrary »>
|13		|Full text image		|if « Y », <note type= »transcriptType »> contains « image »
|14		|Full text		|if « Y », <note type= »transcriptType »> contains « text »
|15		|USTC Classification		|<note type= »keywords »>
|16		|Release date		|Too boring to include
|17 		|URL		|@ref with prefix proquest:

Mapping EEBO spreadsheet fields to bits of a TEI <bibl>
