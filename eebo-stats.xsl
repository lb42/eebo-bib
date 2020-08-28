<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        There are 
        <xsl:value-of select="count(//bibl)"/> records in the catalogue
        of which 
        <xsl:value-of select="count(//bibl[@n])"/> have TCP identifiers

        <xsl:value-of select="count(//bibl/note[@type='transcriptType'][contains(.,'text')])"/> have been transcribed
        <xsl:value-of select="count(//bibl/note[@type='transcriptType'][contains(.,'image')])"/>  have been imaged
        <xsl:value-of select="count(//bibl/@facs[string-length(substring-after(.,':')) &gt; 1])"/>  have imageset identifiers
    </xsl:template>
</xsl:stylesheet>