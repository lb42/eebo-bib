<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs h t"
    xmlns:h="http://www.w3.org/1999/xhtml" 
    xmlns:t="http://www.tei-c.org/ns/1.0" 
      version="2.0">
 
<xsl:output media-type="text" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:text>eeboId, tcpId, date, dateSlot, placePub, lang
</xsl:text>
      <xsl:apply-templates select="//bibl"/>
  </xsl:template>
    
    <xsl:template match="bibl">
    <xsl:value-of select="substring-after(@xml:id,'eebo:')"/><xsl:text>,</xsl:text>
        <xsl:value-of select="@n"/><xsl:text>,</xsl:text>
        <xsl:variable name="dateStr">
           <xsl:value-of select="pubDate"/>
        </xsl:variable>
     <xsl:variable name="firstYr">
      <xsl:analyze-string select="$dateStr"
       regex="(1[567]\d\d)">
       <xsl:matching-substring>
        <xsl:value-of select="regex-group(1)"/>
       </xsl:matching-substring>
      </xsl:analyze-string></xsl:variable>
    
     <xsl:value-of select="$firstYr[1]"/>
       <xsl:text>,</xsl:text>
       <xsl:value-of select="t:doDate($firstYr[1])"/><xsl:text>,</xsl:text>
        <xsl:value-of select="pubPlace"/><xsl:text>,</xsl:text>
        <xsl:value-of select="@xml:lang"/><xsl:text>
        </xsl:text>
        
    </xsl:template> 

<xsl:function name="t:doDate">
    <xsl:param name="dateStr"/>
<xsl:choose>
   <xsl:when test="starts-with($dateStr,'15')">T0</xsl:when> 
    <xsl:when test="$dateStr lt '1640'">T1</xsl:when> 
    <xsl:when test="$dateStr lt '1689'">T2</xsl:when> 
    <xsl:when test="$dateStr lt '1700'">T3</xsl:when> 
    <xsl:when test="starts-with($dateStr,'17')">T4</xsl:when> 
    <xsl:otherwise>T9</xsl:otherwise> 
</xsl:choose>


</xsl:function>

</xsl:stylesheet>