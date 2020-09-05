<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
<xsl:output media-type="text"></xsl:output>
    <xsl:variable name="lookUpDoc" select="document('tls-eebo-full-plus.xml')"/>

    <xsl:key name="tcpLookup" match="bibl" use="substring-after(@n, 'tcp:')"/>

    <xsl:template match="/listBibl">
        <xsl:for-each select="bibl[not(starts-with(@vid,'*')) and not (starts-with(@n, '*'))]">
            <xsl:variable name="tcpId">
                <xsl:value-of select="@xml:id"/>
            </xsl:variable>
            <xsl:variable name="eeboRec">
                <xsl:value-of select="key('tcpLookup', $tcpId, $lookUpDoc)"/>
            </xsl:variable>
           <xsl:if test="string-length($eeboRec) le 1">
               <xsl:value-of select="following-sibling::comment()"/>
                <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text></xsl:if>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
