<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="listE">
 <listBibl>       <xsl:apply-templates select="E"/>
 </listBibl>   </xsl:template>
 <!-- extracts useful bits from eebodat.xml file and from phases.xml for re-use by merger -->   
    <xsl:template match="E">
        <bibl>
            <xsl:variable name="tcpId">
                <xsl:value-of select="IDG/@ID"/>               
            </xsl:variable>
            <xsl:variable name="phase">
                <xsl:value-of select="document('phases.xml')/listB/b[@xml:id eq $tcpId]/substring-after(@n,'phase')"/>
            </xsl:variable>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('tcp',$phase, ':', $tcpId)"/>
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
