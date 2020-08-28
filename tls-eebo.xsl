<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:t="http://www.tei-c.org/ns/1.0" 
   exclude-result-prefixes="xs t"
    version="2.0">
    
    <xsl:template match="/">
        <listBibl>
            <xsl:apply-templates select="//t:row[position() &gt; 1]"/>
        </listBibl>
    </xsl:template>
    


<xsl:template match="t:row">
    <bibl>
        <xsl:attribute name="ref"><xsl:value-of select="concat('proquest:',substring-after(t:cell[17],'view/'))"/></xsl:attribute>
        <xsl:attribute name="xml:id"><xsl:value-of select="concat('eebo:',t:cell[1])"/></xsl:attribute>
        <xsl:if test="string-length(t:cell[2]) &gt; 1">
            <xsl:attribute name="facs">
                <xsl:value-of select="concat('eeboIs:',t:cell[2])"/>
            </xsl:attribute></xsl:if>
        <xsl:attribute name="type">
            <xsl:value-of select="t:cell[3]"/></xsl:attribute>
        <xsl:attribute name="xml:lang"><xsl:value-of select="t:doLang(t:cell[10])"/></xsl:attribute>
        <series><xsl:value-of select="t:cell[4]"/></series>
        <title><xsl:value-of select="t:cell[5]"/></title>
        <author><xsl:value-of select="t:cell[6]"/></author>
    <!--    <imprint>
   -->         <pubDate><xsl:value-of select="t:cell[7]"/></pubDate>
            <publisher><xsl:value-of select="t:cell[8]"/></publisher>
            <pubPlace><xsl:value-of select="t:cell[9]"/></pubPlace>          
        <!--</imprint>-->
       <note type="keywords"><xsl:value-of select="t:cell[15]"/></note> 
       <note type="sourceLibrary"><xsl:value-of select="t:cell[12]"/></note>
       <note type="transcriptType">
                <xsl:if test="starts-with(t:cell[14],'Y')">text </xsl:if>
               <xsl:if test="starts-with(t:cell[13],'Y')">image </xsl:if>
       </note>
        <note type="langNote"><xsl:value-of select="t:cell[10]"/></note>
    </bibl><xsl:text>
</xsl:text>
</xsl:template>
    
    <xsl:function name="t:doLang">
        <xsl:param name="langName"/>
        <xsl:choose>
            <xsl:when test="contains($langName,'Algonquin')">alq</xsl:when>
<xsl:when test="contains($langName,'Ancient')">grc</xsl:when>
<xsl:when test="contains($langName,'Arabic')">ara</xsl:when>
<xsl:when test="contains($langName,'Coptic')">cop</xsl:when>
<xsl:when test="contains($langName,'Dutch')">nld</xsl:when>
<xsl:when test="contains($langName,'English')">eng</xsl:when>
<xsl:when test="contains($langName,'French')">fra</xsl:when>
<xsl:when test="contains($langName,'Gaelic')">gla</xsl:when>
<xsl:when test="contains($langName,'German')">deu</xsl:when>
<xsl:when test="contains($langName,'Greek')">ell</xsl:when>
<xsl:when test="contains($langName,'Hebrew')">heb</xsl:when>
<xsl:when test="contains($langName,'Hungarian')">hun</xsl:when>
<xsl:when test="contains($langName,'Irish')">gle</xsl:when>
<xsl:when test="contains($langName,'Italian')">ita</xsl:when>
<xsl:when test="contains($langName,'Latin')">lat</xsl:when>
<xsl:when test="contains($langName,'Lithuanian')">lit</xsl:when>
<xsl:when test="contains($langName,'Malay')">msa</xsl:when>
<xsl:when test="contains($langName,'Newari')">new</xsl:when>
<xsl:when test="contains($langName,'Persian')">fas</xsl:when>
<xsl:when test="contains($langName,'Portuguese')">oir</xsl:when>
<xsl:when test="contains($langName,'Russian')">rus</xsl:when>
<xsl:when test="contains($langName,'Scots')">sco</xsl:when>
<xsl:when test="contains($langName,'Spanish')">spa</xsl:when>
<xsl:when test="contains($langName,'Syriac')">syr</xsl:when>
<xsl:when test="contains($langName,'Turkish')">tur</xsl:when>
<xsl:when test="contains($langName,'Multiple')">mul</xsl:when>
<xsl:when test="contains($langName,'Not')">zxx</xsl:when>
<xsl:when test="contains($langName,'Welsh')">cym</xsl:when>
            <xsl:otherwise>mis</xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>