<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs h t"
 xmlns:h="http://www.w3.org/1999/xhtml" xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">
 <!-- process tls-eebo-tei.xml
     merging in some data from extracted.xml 
     -->
 <xsl:template match="bibl">
  <xsl:variable name="eeboId">
   <xsl:choose>
    <xsl:when test="contains(@xml:id, '_')">
     <xsl:value-of select="substring-before(substring-after(@xml:id, 'eebo:'), '_')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="substring-after(@xml:id, 'eebo:')"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="vid">
   <xsl:value-of select="substring-after(@facs, 'eeboIs:')"/>
  </xsl:variable>

  <xsl:variable name="theRecord">
   <xsl:copy-of select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]"/>
  </xsl:variable>

  <xsl:variable name="tcpId">
   <!--      <xsl:value-of  select="$theRecord/@xml:id" />
-->
   <xsl:value-of
    select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]/@xml:id"/>
  </xsl:variable>

  <bibl>
   <xsl:choose>
    <xsl:when test="string-length($tcpId) &gt; 1">
     <xsl:attribute name="n">
      <xsl:value-of select="$tcpId"/>
     </xsl:attribute>
     <xsl:apply-templates select="@*"/>
     <xsl:for-each select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]/STC">
      <idno type="STC"> 
       <xsl:choose>
        <xsl:when test="@T = 'S'">STC </xsl:when>
        <xsl:when test="@T = 'C'">ESTC </xsl:when>
        <xsl:when test="@T = 'W'">Wing </xsl:when>       
        <xsl:when test="@T = 'E'">Evans </xsl:when>
        <xsl:when test="@T = 'T'">Thomason </xsl:when>
        <xsl:when test="@T = 'TT'">Thomason </xsl:when>
        <xsl:when test="@T = 'G'">TractSupplement </xsl:when>
        <xsl:when test="@T = 'B'">Broadside </xsl:when>
        <xsl:when test="@T = 'NS'">Nelson </xsl:when>
        <xsl:when test="@T = 'X'">X </xsl:when>       
        <xsl:otherwise>Other <xsl:message><xsl:value-of
         select="concat('Unanticipated STC ', @T, ' in ', $tcpId)"/></xsl:message></xsl:otherwise>
       </xsl:choose>
       <xsl:value-of select="."/>
      </idno>
     </xsl:for-each>
      <xsl:apply-templates/>
     <measure type="pp">
      <xsl:value-of
       select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]/@pp"/>
     </measure>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="@*"/>
     <xsl:apply-templates/>
    </xsl:otherwise>
   </xsl:choose>
  </bibl>
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
