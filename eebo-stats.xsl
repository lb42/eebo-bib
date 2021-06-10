<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
     <xsl:variable name="totalRecs" select="count(/listBibl/bibl)"/>
     <xsl:variable name="totalTCP" select="count(/listBibl/bibl[starts-with(@n,'tcp')])"/>
     <xsl:variable name="totalTCP1" select="count(/listBibl/bibl[starts-with(@n,'tcp1')])"/>
     <xsl:variable name="totalTCP2" select="count(/listBibl/bibl[starts-with(@n,'tcp2')])"/>
     <xsl:variable name="totalTCP0" select="count(/listBibl/bibl[starts-with(@n,'tcp:')])"/>
     <xsl:variable name="T1count" select="count(/listBibl/bibl/pubDate[@n='T1'])"/>
     <xsl:variable name="T2count" select="count(/listBibl/bibl/pubDate[@n='T2'])"/>
     <xsl:variable name="T3count" select="count(/listBibl/bibl/pubDate[@n='T3'])"/>
     <xsl:variable name="T4count" select="count(/listBibl/bibl/pubDate[@n='T4'])"/>
     <xsl:variable name="T9count" select="count(/listBibl/bibl/pubDate[@n='T9'])"/>   
     
  <table>
   <row role="label">
    <cell></cell>
    <cell>count</cell>
    <cell>all TCP</cell>
    <cell>TCP 1</cell>
    <cell>TCP 2</cell>
    <cell>TCP 0</cell>
  </row><row>
    <cell>T1 (before 1640)</cell>
    <cell><xsl:value-of select="$T1count"/></cell>
    <cell><xsl:value-of select="$T1count div $totalRecs"/></cell>   
    <cell><xsl:value-of select="$T1count div $totalTCP"/></cell>   
    <cell><xsl:value-of select="$T1count div $totalTCP1"/></cell>   
    <cell><xsl:value-of select="$T1count div $totalTCP2"/></cell>   
    <cell><xsl:value-of select="$T1count div $totalTCP0"/></cell>   
   </row>
   <row>
    <cell>T2 (1640-1659)</cell>
    <cell><xsl:value-of select="$T2count"/></cell>
    <cell><xsl:value-of select="$T2count div $totalRecs"/></cell>   
    <cell><xsl:value-of select="$T2count div $totalTCP"/></cell>   
    <cell><xsl:value-of select="$T2count div $totalTCP1"/></cell>   
    <cell><xsl:value-of select="$T2count div $totalTCP2"/></cell>   
    <cell><xsl:value-of select="$T2count div $totalTCP0"/></cell>   
   </row>
   <row>
    <cell>T3 (1660-1700)</cell>
    <cell><xsl:value-of select="$T3count"/></cell>
    <cell><xsl:value-of select="$T3count div $totalRecs"/></cell>   
    <cell><xsl:value-of select="$T3count div $totalTCP"/></cell>   
    <cell><xsl:value-of select="$T3count div $totalTCP1"/></cell>   
    <cell><xsl:value-of select="$T3count div $totalTCP2"/></cell>   
    <cell><xsl:value-of select="$T3count div $totalTCP0"/></cell>   
   </row>
   <row>
    <cell>T4 (1701-)</cell>
    <cell><xsl:value-of select="$T4count"/></cell>
    <cell><xsl:value-of select="$T4count div $totalRecs"/></cell>   
    <cell><xsl:value-of select="$T4count div $totalTCP"/></cell>   
    <cell><xsl:value-of select="$T4count div $totalTCP1"/></cell>   
    <cell><xsl:value-of select="$T4count div $totalTCP2"/></cell>   
    <cell><xsl:value-of select="$T4count div $totalTCP0"/></cell>   
   </row>
   <row>
    <cell>All </cell>
    <cell><xsl:value-of select="$totalRecs"/></cell>
    <cell><xsl:value-of select="$totalTCP"/> (<xsl:value-of select="$totalTCP div $totalRecs"/>)</cell>   
    <cell><xsl:value-of select="$totalTCP1"/> (<xsl:value-of select="$totalTCP1 div $totalRecs"/>)</cell>   
    <cell><xsl:value-of select="$totalTCP2"/> (<xsl:value-of select="$totalTCP2 div $totalRecs"/>)</cell>   
    <cell><xsl:value-of select="$totalTCP0"/> (<xsl:value-of select="$totalTCP0 div $totalRecs"/>)</cell>   
    </row>
  </table>   
     <!--   There are 
        <xsl:value-of select=""/> records in the PQ catalogue
        of which 
        <xsl:value-of select="count(/listBibl/bibl)"/> have TCP identifiers
        <xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp1')  or starts-with(@n,'tcp2')])"/> are boxed up
        (<xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp1')])"/> phase 1 and <xsl:value-of select="count(/listBibl/bibl[starts-with(@n,'tcp2')])"/> phase 2)
     
        The catalogue identifies
        <xsl:value-of select="count(/listBibl/bibl/note[@type='transcriptType'][contains(.,'text')])"/>  transcribed
        <xsl:value-of select="count(/listBibl/bibl/note[@type='transcriptType'][contains(.,'image')])"/>  imaged
        <xsl:value-of select="count(/listBibl/bibl/@facs[string-length(substring-after(.,':')) &gt; 1])"/>  with imageset identifiers-->
    </xsl:template>
</xsl:stylesheet>