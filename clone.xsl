<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs h"
    xmlns:h="http://www.w3.org/1999/xhtml" 
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    
    xmlns="http://www.tei-c.org/ns/1.0" 
    version="2.0">
   
<xsl:template match="t:bibl">
    <xsl:variable name="eeboId">
        <xsl:value-of select="substring-after(@xml:id, 'eebo:')"/>
    </xsl:variable>
    <xsl:variable name="tcpId">
        <xsl:value-of select="document('TCP.xml')/t:table/t:row/t:cell[@n='2'][contains(.,$eeboId)]/preceding-sibling::t:cell"/>
    </xsl:variable>
    <xsl:attribute name="n">
        <xsl:value-of select="concat('tcp:',$tcpId)"/>
    </xsl:attribute>
</xsl:template>


 <xsl:template match="* | @* | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="."/>
        <!-- could normalize() here -->
    </xsl:template>
</xsl:stylesheet>