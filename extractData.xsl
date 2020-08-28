<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="listE">
 <listBibl>       <xsl:apply-templates select="E"/>
 </listBibl>   </xsl:template>
    
    <xsl:template match="E">
        <bibl>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="IDG/@ID"/>
            </xsl:attribute>
            <xsl:attribute name="n">
                <xsl:value-of select="IDG/BIBNO"/>
            </xsl:attribute>
            <xsl:attribute name="vid">
                <xsl:value-of select="IDG/VID"/>
            </xsl:attribute>
            <xsl:attribute name="pp">
                <xsl:value-of select="IMGS"/>
            </xsl:attribute>
        </bibl><xsl:text>
</xsl:text>
    </xsl:template>
</xsl:stylesheet>
