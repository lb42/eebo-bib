<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
       <xsl:output method="xml" indent="yes"/>
<xsl:template match="/">   
             <keywords>
                      <xsl:apply-templates select="//note[@type='keywords']"/>
            </keywords>
 
        </xsl:template>
 
 <xsl:template match="note[@type='keywords']"> 
  <xsl:for-each select="tokenize(.,'[\|\.]')">
   <term><xsl:value-of select="."/></term>
  </xsl:for-each>
 </xsl:template>
        
</xsl:stylesheet>