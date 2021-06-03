<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs h t"
 xmlns:h="http://www.w3.org/1999/xhtml" xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0" version="2.0">
 <!-- read an existing TCP file as output by tcp2tei enriching it with
    * catalogue numbers from eebodat1.xml (as maintained by PFS) if necessary
    * new PQ number from tls-eebo.part.xml
    * updated publication stmt
    * link to jisc historical texts site
    * note on storage sites
    * change notice
    In text body:
    * retain existing @facs values even though they are not currently working because proquest
    * retain (for now) @rend values unchanged except for 
    * change add/@rend to add/@place
    
    LB 2021-05-22
-->


 <xsl:template match="t:idno[@type = 'DLPS']">
<!-- do TCP id -->
  <xsl:variable name="TCPid">
   <xsl:value-of select="//t:idno[@type = 'DLPS'][1]"/>
  </xsl:variable>
  
  <idno type="DLPS" xmlns:t="http://www.tei-c.org/ns/1.0">
   <xsl:value-of select="."/>
  </idno>
<!-- do  MARC id -->  
  <xsl:variable name="MARCid">
   <xsl:value-of
    select="document('/home/lou/Public/eebo-bib/tls-eebo-2021-part.xml')/listBibl/bibl[substring-after(@n, ':') = $TCPid][1]/substring-after(@xml:id, ':')"   />
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($MARCid) le 1">
    <xsl:message>No MARC id found in Proquest data for <xsl:value-of select="$TCPid"/>: using eebodat</xsl:message>
    <xsl:if test="string-length(document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/BIBNO) &gt; 0">
     <idno type="EEBO-CITATION">
      <xsl:value-of select="document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/BIBNO"/>
     </idno>
    </xsl:if> 
   </xsl:when>
   <xsl:otherwise>
    <idno type="EEBO-CITATION">
     <xsl:value-of select="$MARCid"/>
    </idno></xsl:otherwise></xsl:choose>
  <xsl:text>
  </xsl:text>
<!-- do the VID -->  
  <xsl:variable name="VID">
   <xsl:value-of
    select="document('/home/lou/Public/eebo-bib/tls-eebo-2021-part.xml')/listBibl/bibl[substring-after(@n, ':') = $TCPid][1]/substring-after(@facs, ':')"   />
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($VID) le 1">
    <xsl:message>No VID found in Proquest data for <xsl:value-of select="$TCPid"/>: using eebodat</xsl:message>
    <xsl:if test="string-length(document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/VID) &gt; 0">
     <idno type="VID">
      <xsl:value-of select="document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/VID"/>
     </idno>
    </xsl:if> 
   </xsl:when>
   <xsl:otherwise>
    <idno type="VID">
     <xsl:value-of select="$VID"/>
    </idno></xsl:otherwise></xsl:choose>
  <xsl:text>
  </xsl:text>
  
  <!-- do the GOID -->
   <xsl:variable name="GOID">
   <xsl:value-of
    select="document('/home/lou/Public/eebo-bib/tls-eebo-2021-part.xml')/listBibl/bibl[substring-after(@n, ':') = $TCPid][1]/substring-after(@ref, ':')"
   />
  </xsl:variable>

  <xsl:if test="string-length($GOID) &gt; 2">
   <idno type="EEBO-PROQUEST">
    <xsl:value-of select="$GOID"/>
    </idno>
   <xsl:text>
  </xsl:text>
  </xsl:if>
<!-- if there are no STC ids in this file, look for them in proquest data -->
  <xsl:if test="not(../t:idno[@type = 'STC'])">
   <xsl:choose>
    <xsl:when test="count(document('/home/lou/Public/eebo-bib/tls-eebo-2021-part.xml')/listBibl/bibl[substring-after(@n, ':') = $TCPid][1]/idno[@type='STC']) &gt; 0">
   <xsl:for-each select="document('/home/lou/Public/eebo-bib/tls-eebo-2021-part.xml')/listBibl/bibl[substring-after(@n, ':') = $TCPid][1]/idno[@type='STC']">    
   <idno type="STC">  
     <xsl:value-of select="."/>
    </idno>
    <xsl:text>
  </xsl:text></xsl:for-each></xsl:when>
    <xsl:when test="count(document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/STC) &gt; 0">
     <xsl:message>No STCs found in Proquest data for <xsl:value-of select="$TCPid"/>: trying eebodat</xsl:message>     
     <xsl:for-each select="document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/STC">    
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
         select="concat('Unanticipated STC ', @T, ' in ', $TCPid)"/></xsl:message></xsl:otherwise>
       </xsl:choose>
       <xsl:value-of select="."/>
      </idno>
      <xsl:text>
  </xsl:text></xsl:for-each></xsl:when>
    <xsl:otherwise>
     <xsl:message>No STCs found for <xsl:value-of select="$TCPid"/></xsl:message>   
    </xsl:otherwise>
  </xsl:choose>
  </xsl:if>

 </xsl:template>

<xsl:template match="t:idno[@type='OCLC'][starts-with(.,'ocm')]">
 <idno type='OCLC'>
  <xsl:value-of select="substring-after(.,'ocm ')"/>
 </idno>
</xsl:template>
 
 <xsl:template match="t:availability">
  <availability>
   <p>This keyboarded and encoded edition of the work described above is co-owned by the
    institutions providing financial support to the Early English Books Online Text Creation
    Partnership. This text is available for reuse, according to the terms of <ref
    target="https://creativecommons.org/publicdomain/zero/1.0/"> Creative Commons 0 1.0 Universal
    licence</ref>. The text can be copied, modified, distributed and performed, even for commercial
    purposes, all without asking permission.</p>
  </availability>
 </xsl:template>


 <!--    <prefixDef ident="tcp" matchPattern="([0-9\-]+):([0-9IVX]+)" replacementPattern="http://eebo.chadwyck.com/downloadtiff?vid=$1&amp;page=$2"/>
     https://data.historicaltexts.jisc.ac.uk/view?pubId=ecco-$1&amp;index=ecco&amp;pageId=ecco-$1-$20  
 https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-99845992e
 -->
 <!--<xsl:template match="t:prefixDef[@ident='tcp']/@replacementPattern">
  <xsl:value-of select="concat('https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-',
     $MARCid, 'e &amp;index=eebo&amp;pageId=eebo-', $MARCid, 'e-$1-$2')"/> 
 </xsl:template>
-->
 <xsl:template match="t:fileDesc/t:notesStmt">
  <xsl:variable name="TCPid">
   <xsl:value-of
    select="ancestor::t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type = 'DLPS'][1]"/>
  </xsl:variable>

  <xsl:variable name="MARCid">
   <xsl:value-of select="document('eebodat1.xml')/listM/E/IDG[@ID = $TCPid]/BIBNO[@T = 'umi']"/>
  </xsl:variable>
  <notesStmt>
   <relatedItem type="facs">
    <xsl:attribute name="target">
     <xsl:value-of
      select="concat('https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-', $MARCid, 'e')"/>
    </xsl:attribute>
   </relatedItem>
   <xsl:apply-templates/>
  </notesStmt>
 </xsl:template>
 <xsl:template match="t:editorialDecl/t:p[9]">
  <p>Full documentation of the original data capture process is available from the <ref
   target="http://www.textcreationpartnership.org/docs/.">Text Creation Partnership web site</ref>.
   All versions of the texts are now archived and freely available for download. See <ref
    target="https://textcreationpartnership.org/faq/#faq05">the TCP Download FAQ</ref>
   for detailed information. The TEI P5 versions are also freely available from the <ref
   target="https://github.com/textcreationpartnership">TCP Github repository</ref>.</p>
 </xsl:template>

 <xsl:template match="t:revisionDesc">
  <revisionDesc>
   <xsl:apply-templates/>
   <change> <date>2021-05 </date> <label>lb</label>TEI P5 conversion </change>
  </revisionDesc>
 </xsl:template>

 <!--<xsl:template match="@rend[. = 'above']">
  <xsl:attribute name="place">above</xsl:attribute>
 </xsl:template>
 <xsl:template match="@rend[. = 'below']">
  <xsl:attribute name="place">below</xsl:attribute>
 </xsl:template>
 <xsl:template match="@rend[. = 'indent']">
  <xsl:attribute name="place">block</xsl:attribute>
 </xsl:template>
 <xsl:template match="@rend[. = 'hangingIndent']">
  <xsl:attribute name="place">block</xsl:attribute>
 </xsl:template>-->
 
 <!-- this loses distinction between hanging and other indents -->

 <!--<xsl:template match="@rend">
  <xsl:attribute name="rendition">
   <xsl:choose>
    <xsl:when test=". eq 'blackletterType'">simple:blackletter</xsl:when>
    <!-\- (351)-\->
    <xsl:when test=". eq 'block'">simple:display</xsl:when>
    <!-\- (1)-\->
    <xsl:when test=". eq 'braced'">simple:leftbraced</xsl:when>
    <!-\- (1)-\->
    <xsl:when test=". eq 'centerJustify'">simple:centre</xsl:when>
    <!-\- (15)-\->
    <xsl:when test=". eq 'decorInit'">simple:dropcap</xsl:when>
    <!-\- (9597)-\->
    <xsl:when test=". eq 'inline'">simple:inline</xsl:when>
    <!-\- (500)-\->
    <xsl:when test=". eq 'italic'">simple:italic</xsl:when>
    <!-\- (1871)-\->
    <xsl:when test=". eq 'large'">simple:larger</xsl:when>
    <!-\- (1)-\->
    <xsl:when test=". eq 'leftJustify'">simple:left</xsl:when>
    <!-\- (50)-\->
    <xsl:when test=". eq 'rightJustify'">simple:right</xsl:when>
    <!-\- (71)-\->
    <xsl:when test=". eq 'roman'">simple:normalstyle</xsl:when>
    <!-\- (398)-\->
    <xsl:when test=". eq 'small'">simple:smaller</xsl:when>
    <!-\- (63)-\->
    <xsl:when test=". eq 'sub'">simple:subscript</xsl:when>
    <!-\- (9)-\->
    <xsl:when test=". eq 'sup'">simple:superscript</xsl:when>
    <!-\- (34975)-\->
    <xsl:when test=". eq 'upsideDown'">simple:</xsl:when>
    <!-\- (5)-\->

    <xsl:otherwise>
     <xsl:value-of select="."/>
     <xsl:message>
      <xsl:value-of
       select="concat('Unanticipated @rend ', ., ' in ', ancestor::t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type = 'DLPS'][1])"
      />
     </xsl:message>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>
-->
<!--<xsl:template match="t:add/@rend">
 <xsl:attribute name="place">
  <xsl:value-of select="."/>
 </xsl:attribute>
</xsl:template>-->

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
