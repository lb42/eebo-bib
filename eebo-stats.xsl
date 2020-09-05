<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        There are 
        <xsl:value-of select="count(/listBibl/bibl)"/> records in the PQ catalogue
        of which 
        <xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp')])"/> have TCP identifiers
        <xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp1')  or starts-with(@n,'tcp2')])"/> are boxed up
        (<xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp1')])"/> phase 1 and <xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp2')])"/> phase 2)
        The catalogue identifies
        <xsl:value-of select="count(/listBibl/bibl/note[@type='transcriptType'][contains(.,'text')])"/>  transcribed
        <xsl:value-of select="count(/listBibl/bibl/note[@type='transcriptType'][contains(.,'image')])"/>  imaged
        <xsl:value-of select="count(/listBibl/bibl/@facs[string-length(substring-after(.,':')) &gt; 1])"/>  with imageset identifiers
    </xsl:template>
</xsl:stylesheet>